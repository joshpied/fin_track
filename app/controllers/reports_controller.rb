class ReportsController < ApplicationController
  before_action :require_login 

  def index
    @current_month = Time.now.month
    @current_year = Time.now.year
    @reports = 
      current_user
      .reports
      .order("report_date asc")
      .limit(12)
      .pluck(:report_date, :total_amount, :id)

    @area_chart_reports = @reports.map{ |report_date, total_amount| [report_date.strftime("%B %Y"), total_amount] }
    @recent_monthly_report = @reports.last
    @previous_monthly_reports = @reports[0...-1].reverse.take(6)
    @yearly_reports = current_user.reports.distinct.pluck(:year).sort_by { |year| }
    
    # @total_spent_year = current_user.reports.where("year = ?", @current_year).sum(:total_amount)
      
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
    @transaction_category_colors = []
    @transaction_categories.each do |category, _|
      @transaction_category_colors << helpers.transaction_category_color(category)
    end
  end

  def show
    report_id = params[:id]
    @report = 
      current_user
      .reports
      .left_outer_joins(:budget)
      .find(report_id)

    if @report.budget.present?
      @spent_budget_difference = @report.budget.amount - @report.total_amount
      @is_overbudget = @spent_budget_difference < 0 ? true : false
    else
      @is_overbudget = false
    end
      
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

  def years
    # array of unique reporting years
    @pagy_a, @years = pagy_array(current_user.reports.distinct.pluck(:year).sort_by { |year| }, items: 8)
    @spending = []
    # get total spending for each year (need to sort by ascending)
    @years.sort.each do |year|
      @spending.push(current_user.reports.where("year = ?", year).sum(:total_amount).to_f)
    end
    
    @spending_by_year = @years.sort.zip(@spending) # combine into array of arrays eg. [ [year, spending] ]
  end

  def year
    @year = params[:year]

    @reports = 
      current_user
      .reports
      .left_outer_joins(:budget)
      .where("year = ?", @year)
      .order("report_date asc")

    @monthly_spending = @reports.map { |report| [Date::MONTHNAMES[report.month], report.total_amount.to_f] }

    @total_spent_year = current_user.reports.where("year = ?", @year).sum(:total_amount)
    
    # hash of transaction_category.name => transaction.amount spent this year
    @transaction_categories = 
      current_user
      .transactions
      .where('extract(year from transaction_date) = ?', @year)
      .includes(:transaction_category)
      .group("transaction_categories.name")
      .sum(:amount)
      .sort_by { |category, amount| amount }
      .reverse  

    @transaction_category_colors = []
    @transaction_categories.each do |category, _|
      @transaction_category_colors << helpers.transaction_category_color(category)
    end
  end
end
