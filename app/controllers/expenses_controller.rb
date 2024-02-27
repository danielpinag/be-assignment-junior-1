# frozen_string_literal: true

class ExpensesController < ApplicationController
  def create
    byebug
    result = Expenses::Create.call(user: current_user, expense_params: expense_params.to_h)

    if result.success?
      redirect_to root_path, notice: 'Expense created'
    else
      redirect_to root_path, alert: result.errors.full_messages.join(', ')
    end
  end

  private

  def expense_params
    params[:expense][:users_params] = JSON.parse(params[:expense][:users_params])
    params.require(:expense).permit(:amount, :name, :description, :equally_shared, users_params: [:user_id, :amount])
  end
end
