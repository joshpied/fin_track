class Report < ApplicationRecord
  has_many :transactions

  def to_s
    report_date.strftime("%B %Y")
  end
end
