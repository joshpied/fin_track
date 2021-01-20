class DashboardsController < ApplicationController
  before_action :require_login 

  def index
    @year = Time.now.year
    @recent_report = 
      current_user
      .reports
      .where("month = ? AND year = ?", Time.now.month, Time.now.year)
      .first
  end
  
end
