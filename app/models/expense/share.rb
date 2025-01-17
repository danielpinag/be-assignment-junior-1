# frozen_string_literal: true

class Expense::Share < ApplicationRecord
  belongs_to :expense
  belongs_to :user
  has_many :payments, class_name: 'Expense::Share::Payment', foreign_key: 'expense_share_id'

  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 'pending', paid: 'paid', partially_paid: 'partially_paid' }

  scope :to_pay_to, ->(expense_owner) { joins(:expense).where(expenses: { owner_id: expense_owner.id }, status: %i[pending partially_paid]).where.not(user_id: expense_owner.id) }

  def paid_amount
    payments.sum(:amount)
  end

  def remaining_amount
    amount - paid_amount
  end

  def owner_name_and_amount
    "#{expense.owner.name} - #{amount}"
  end
end
