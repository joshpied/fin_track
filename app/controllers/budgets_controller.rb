class BudgetsController < ApplicationController
  before_action :require_login 
  @@current_month = Time.now.month
  @@current_year = Time.now.year
  
  def new
    report = current_user.reports.left_outer_joins(:budget).find_by(month: @@current_month, year: @@current_year)
    puts report
    if report.budget.present? 
      redirect_back(fallback_location: reports_path)
    end
    @budget = current_user.budgets.build
  end

  def create
    report = current_user.reports.find_by(month: @@current_month, year: @@current_year)
    
    if report
      @budget = current_user.budgets.new(amount: budget_params[:amount], report_id: report.id)
    end
    
    if @budget.save
      redirect_to report_path(report), notice: "Budget Created!"
    else
      @errors = @budget.errors.full_messages
      render :new
    end
  end

  def edit
    @budget = current_user.budgets.find(params[:id])
  end

  def update
    @budget = current_user.budgets.find(params[:id])

    if @budget.update_attributes(budget_params)
      redirect_to report_path(@budget.report_id), notice: "Budget Updated!"
    else
      @errors = @budget.errors.full_messages
      render :edit
    end
  end

  def destroy
    @budget = current_user.budgets.find(params[:id])
    
    if @budget.destroy
      # flash[:success] = 'Budget was successfully deleted.'
      redirect_to report_path(@budget.report_id), notice: "Budget Deleted"
    else
      flash[:error] = 'Something went wrong'
      redirect_to report_path(@budget.report_id)
    end
  end

  private 
  def budget_params
    params.require(:budget).permit(:amount)
  end
  
end
