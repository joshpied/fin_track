class TransactionsController < ApplicationController
  before_action :require_login 

  def index
    @current_month = Time.new.strftime("%B")
    @transactions = current_user.transactions.joins(:transaction_category).order(transaction_date: :desc) # also need to add where clause for current month
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
      redirect_to transaction_path(@transaction), notice: "Transaction Created!"
    else
      @errors = @transaction.errors.full_messages
      render :new
    end
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
  end

  def update
    @transaction = current_user.transactions.find(params[:id])

    if @transaction.update_attributes(transaction_params)
      redirect_to transaction_path(@transaction), notice: "Transaction Updated!"
    else
      @errors = @transaction.errors.full_messages
      render :edit
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    if @transaction.destroy
      flash[:success] = 'Transaction was successfully deleted.'
      redirect_to transactions_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to transactions_url
    end
  end
  


  private 

  def transaction_params
    params.require(:transaction).permit(:amount, :note, :transaction_date, :transaction_category_id)
  end
  
end
