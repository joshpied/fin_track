class Report < ApplicationRecord
  has_many :transactions
  has_one :budget

  def month_name
    report_date.strftime("%B")
  end

  # Formats a report like "December 2020"
  def to_s
    report_date.strftime("%B %Y")
  end
end
