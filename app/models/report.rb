class Report < ApplicationRecord
  has_many :transactions

  # Formats a report like "December 2020"
  def to_s
    report_date.strftime("%B %Y")
  end
end
