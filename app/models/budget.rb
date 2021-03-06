class Budget < ApplicationRecord
  belongs_to :report
  belongs_to :user

  # Month number to name eg. 1 -> January
  def month_name
    report_date.strftime("%B")
  end

  # Formats a report like "December 2020"
  def to_s
    report_date.strftime("%B %Y")
  end
end
