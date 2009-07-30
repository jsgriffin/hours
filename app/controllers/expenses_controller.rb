class ExpensesController < ApplicationController

  def create
    @client = Client.find( params[:client_id] )
    
    @expense = @client.expenses.build( params[:expense] )
    
    if @expense.save 
    	flash[:notice] = "Expense was created successfully"
    else
    	flash[:notice] = "Expense could not be saved"
    end
   	redirect_to "/dashboard"
    
  end

  def update
    @expense = Expense.find(params[:id])

    if @expense.update_attributes(params[:expense])
      flash[:notice] = 'Expense was successfully updated.'
    else
	  flash[:notice] = "Expense could not be updated, sorry! Please try again."
    end
    
    redirect_to "/dashboard"
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    flash[:notice] = "The expense was deleted successfully"
    redirect_to "/dashboard"
  end
end
