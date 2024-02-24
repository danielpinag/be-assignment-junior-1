# frozen_string_literal: true

class Expense::Share < ApplicationRecord
  belongs_to :expense
  belongs_to :user
  has_many :payments

  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 'pending', paid: 'paid', partially_paid: 'partially_paid' }
end
