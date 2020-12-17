class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_category
  belongs_to :report

  def date_formatted
    transaction_date.strftime("%d %b %Y")
  end
  
end