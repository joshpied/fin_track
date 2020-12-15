class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_category

  def date_formatted
    transaction_date.strftime("%d %b %Y")
  end
  
end