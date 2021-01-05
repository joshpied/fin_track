class ReportsController < ApplicationController
  before_action :require_login 

  def index
    current_month = Time.now.month
    current_year = Time.now.year
    # most recent report object
    @recent_report = 
      current_user
      .reports
      .where("month = ? AND year = ?", current_month, current_year)
      .first 
    # if @recent_report
      # reports array (excluding recent report)
      @reports = 
        current_user
        .reports
        .where
        .not("month = ? AND year = ?", current_month, current_year)
        .order("report_date desc")
        # .pluck(:id, :report_date)
        
      # hash of transaction_category.name => transaction.amount spent this month
      @transaction_categories = 
        current_user
        .transactions
        .where('extract(year from transaction_date) = ?', current_year)
        .includes(:transaction_category)
        .group("transaction_categories.name")
        .sum(:amount)
        .sort_by { |category, amount| amount }
        .reverse
    # end
      
  end

  def show
    report_id = params[:id]
    @report = 
      current_user.reports
      .find(report_id)
    @transactions = 
      current_user.transactions
      .where("report_id = ?", report_id)
    @transaction_categories = 
      current_user.transactions
      .where("report_id = ?", report_id)
      .includes(:transaction_category)
      .group("transaction_categories.name")
      .sum(:amount)
      .sort_by { |category, amount| amount }
      .reverse
  end
  
  
end
