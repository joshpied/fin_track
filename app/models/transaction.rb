class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_category
  belongs_to :report
  after_save :update_report_amount

  # increase the transaction's report total amount for the month
  def update_report_amount
    report = Report.find(self.report_id)
    report.update_column(:total_amount, report.total_amount + self.amount)
    report.save
  end

  def date_formatted
    transaction_date.strftime("%d %b %Y")
  end
  
end