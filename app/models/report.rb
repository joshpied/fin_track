class Report < ApplicationRecord
  has_many :transactions
  has_one :budget

  # scope :with_budget, -> (report_id) { includes(:budget).where('budgets.id IS NOT NULL') }

  def month_name
    report_date.strftime("%B")
  end

  # Formats a report like "December 2020"
  def to_s
    report_date.strftime("%B %Y")
  end

  # TODO add method to check if it is/isnt "locked", i.e. is not present month+year
end
