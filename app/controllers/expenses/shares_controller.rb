# frozen_string_literal: true

class Expenses::SharesController < ApplicationController
  def new_payment
    @share = ::Expense::Share.find(params[:share_id])
    render partial: 'expenses/payments/form', locals: { payment: @payment }
  end
end
