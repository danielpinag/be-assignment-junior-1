# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @expenses_to_receive = user.expense_shares.to_pay_to(current_user)
    @expenses_to_pay = current_user.expense_shares.to_pay_to(user)

    @expenses_to_receive_total = @expenses_to_receive.sum(&:remaining_amount)
    @expenses_to_pay_total = @expenses_to_pay.sum(&:remaining_amount)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
