class TransactionsController < ApplicationController
  before_action :require_login 

  def index
    @transactions = current_user.transactions.joins(:transaction_category).order(created_at: :desc) # also need to add where clause for current month
    # @transactions = current_user.transactions.joins("INNER JOIN transaction_categories ON transaction_categories.id = transactions.transaction_category_id").order(:id)
    # puts @transactions.to_json
  end

  def show
    @transaction = current_user.transactions.joins(:transaction_category).find(params[:id])
  end

  def new
    @transaction = current_user.transactions.build
  end
  
  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to transaction_path(@transaction), notice: "transaction Created!"
    else
      @errors = @transaction.errors.full_messages
      render :new
    end
  end


  private 

  def transaction_params
    params.require(:transaction).permit(:amount, :note, :transaction_category_id)
  end
  
end
