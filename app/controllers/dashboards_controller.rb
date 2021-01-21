class DashboardsController < ApplicationController
  before_action :require_login 

  def index
    @year = Time.now.year
    @recent_report = 
      current_user
      .reports
      .left_outer_joins(:budget)
      .where("month = ? AND year = ?", Time.now.month, Time.now.year)
      .first
    if @recent_report.budget.present?
      @spent_budget_difference = @recent_report.budget.amount - @recent_report.total_amount
      @is_overbudget = @spent_budget_difference < 0 ? true : false
    else
      @is_overbudget = false
    end
  end
  
end
