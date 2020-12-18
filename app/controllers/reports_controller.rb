class ReportsController < ApplicationController
  before_action :require_login 

  def index
    current_month = Time.now.month
    current_year = Time.now.year
    @recent_report = current_user.reports.where("month = ? AND year = ?", current_month, current_year).first # most recent report object
    @reports = current_user.reports.order("report_date desc") # reports array
    # hash of transaction_category.name => transaction.amount spent this month
    @transaction_categories = 
      current_user.transactions
      .where("report_id = ?", @recent_report.id)
      .includes(:transaction_category)
      .group("transaction_categories.name")
      .sum(:amount)
    
  end
  
end
