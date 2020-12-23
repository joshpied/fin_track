class TransactionsController < ApplicationController
  before_action :require_login 
  @@current_month = Time.now.month
  @@current_year = Time.now.year

  def index
    @current_month_name = Time.new.strftime("%B")
    @transactions = 
      current_user
      .transactions
      .joins(:transaction_category)
      .order("transaction_date desc, id desc")
      .where("MONTH(transaction_date) = ? AND YEAR(transaction_date) = ?", @@current_month, @@current_year)
  end

  def show
    @transaction = current_user.transactions.joins(:transaction_category).find(params[:id])
  end

  def new
    @transaction = current_user.transactions.build
  end
  
  ##
  # Creates a new transaction and creates/updates a report if it is the first transaction of the month
  def create
    # need to check if report for this month/year exists yet and create it if not
    report = current_user
            .reports
            .find_or_create_by(:month => @@current_month, :year => @@current_year) do |report|
              report.total_amount = 0.00
              report.report_date = transaction_params[:transaction_date]
            end
    
    # can now add a transaction
    @transaction = current_user.transactions.new(
      note: transaction_params[:note], 
      amount: transaction_params[:amount], 
      transaction_date: transaction_params[:transaction_date],
      transaction_category_id: transaction_params[:transaction_category_id],
      report_id: report.id
    )

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
    params.require(:transaction).permit(:amount, :note, :transaction_date, :transaction_category_id, :report_id)
  end

  # helper_method :current_month
  # def current_month
  #   @@current_month
  # end
  
end
