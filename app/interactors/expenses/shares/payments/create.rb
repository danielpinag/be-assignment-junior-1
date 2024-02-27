# frozen_string_literal: true

class Expenses::Shares::Payments::Create < ApplicationInteractor
  def call
    method_id = if context.user.payment_methods.empty?
                  # TODO: - Add POST /payment_methods to create a new payment method
                  PaymentMethod.create!(name: 'Cash', user_id: context.user.id, description: 'Cash payment method').id
                else
                  context.user.payment_methods.where(name: 'Cash').first.id
                end

    payment = context.expense_share.payments.build(context.payment_params.merge(payment_method_id: method_id).compact)
    if payment.save
      handle_share_status!(payment)
      context.payment = payment
    else
      context.fail!(errors: payment.errors)
    end
  end

  private

  def handle_share_status!(payment)
    share = payment.expense_share
    return share.paid! unless share.remaining_amount.positive?

    share.partially_paid!
  end
end
