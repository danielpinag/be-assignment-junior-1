# frozen_string_literal: true

class Expenses::Shares::PaymentsController < ApplicationController
  def create
    result = Expenses::Shares::Payments::Create.call(user: current_user, expense_share: expense_share, payment_params: payment_params.to_h)

    if result.success?
      redirect_to root_path, notice: 'Payment created'
    else
      redirect_to root_path, alert: result.errors.full_messages.join(', ')
    end
  end

  private

  def expense_share
    @expense_share ||= Expense::Share.find(params[:share_id])
  end

  def payment_params
    params.require(:expense_share_payment).permit(:amount, :proof)
  end
end
