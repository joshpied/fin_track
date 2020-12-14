class TransactionsController < ApplicationController
  before_action :require_login 

  def index
    @transactions = current_user.transactions.joins(:transaction_category).order(created_at: :desc) # also need to add where clause for current month
    # @transactions = current_user.transactions.joins("INNER JOIN transaction_categories ON transaction_categories.id = transactions.transaction_category_id").order(:id)
    # puts @transactions.to_json
  end
  
end
