class ReportsController < ApplicationController
  before_action :require_login 

  def index
    @current_month = Time.now.month
    @current_year = Time.now.year
    # current monthly report
    @recent_report = 
      current_user
      .reports
      .where("month = ? AND year = ?", @current_month, @current_year)
      .first 
    # previous monthly reports
    @reports = 
      current_user
      .reports
      .where
      .not("month = ? AND year = ?", @current_month, @current_year)
      .order("report_date desc")
      .limit(6)
      # .pluck(:id, :report_date)
    
    @total_spent_year = current_user.reports.where("year = ?", @current_year).sum(:total_amount)
      
    # hash of transaction_category.name => transaction.amount spent this year
    @transaction_categories = 
      current_user
        .transactions
        .where('extract(year from transaction_date) = ?', @current_year)
        .includes(:transaction_category)
        .group("transaction_categories.name")
        .sum(:amount)
        .sort_by { |category, amount| amount }
        .reverse  
  end

  def show
    report_id = params[:id]
    @report = 
      current_user
      .reports
      .left_outer_joins(:budget)
      .find(report_id)
      
    @transactions_pagy,
    @transactions = 
      pagy(
        current_user
        .transactions
        .where("report_id = ?", report_id)
        .order("transaction_date desc"),
        items: 8
      )

    @transaction_categories = 
      current_user
      .transactions
      .where("report_id = ?", report_id)
      .includes(:transaction_category)
      .group("transaction_categories.name")
      .sum(:amount)
      .sort_by { |category, amount| amount }
      .reverse
  end

  def months
    @pagy, @reports = pagy(current_user.reports.left_outer_joins(:budget).order("report_date desc"), items: 12)
  end
  
  
end
