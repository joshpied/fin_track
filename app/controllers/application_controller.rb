class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pagy::Backend

  # before_action :get_recent_report

  # def get_recent_report
  #   if current_user
  #     @recent_report_id = 
  #       current_user
  #       .reports
  #       .where("month = ? AND year = ?", Time.now.month, Time.now.year)
  #       .pluck(:id)
  #       .first
  #   end
  # end
end
