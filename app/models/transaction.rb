class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_category
  belongs_to :report
  after_create :increase_report_amount
  after_update :update_report_amount
  after_destroy :decrease_report_amount

  # On creation increase the transaction's report total_amount for the month
  def increase_report_amount
    report = Report.find(self.report_id)
    report.update_column(:total_amount, report.total_amount + self.amount)
    report.save
  end

  # On update add the new transaction amount and subtract the old transaction amount from the report
  def update_report_amount
    report = Report.find(self.report_id)
    report.update_column(:total_amount, report.total_amount + self.amount - self.amount_before_last_save)
    report.save
  end

  # On deletion of a transaction remove it's total from the report total_amount
  def decrease_report_amount
    report = Report.find(self.report_id)
    report.update_column(:total_amount, report.total_amount - self.amount)
    report.save
  end

  # Formats transaction date like "25 Dec 2020"
  def date_formatted
    transaction_date.strftime("%e %b %Y")
  end
  
end