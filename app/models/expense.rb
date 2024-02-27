# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :category, class_name: 'ExpenseCategory'

  has_many :expense_shares, class_name: 'Expense::Share', dependent: :destroy
  has_many :users, through: :expense_shares

  validates :amount, :name, :owner, :category, :status, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validate :shares_equal_amount

  enum status: { pending: 'pending', paid: 'paid', partially_paid: 'partially_paid' }

  accepts_nested_attributes_for :expense_shares

  private

  def shares_equal_amount
    expense_shares.sum(&:amount) == amount
  end
end
