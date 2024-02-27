class StaticController < ApplicationController
  def dashboard
    # TODO: Add cookies to get user's most-interacted-with friends
    @friends = current_user.friends.first(5)
    @current_user_expense_shares = current_user.expense_shares.where(status: ['pending', 'partially_paid'])
    @current_user_expense_shares_to_receive = Expense::Share.to_pay_to(current_user)
  end
end
