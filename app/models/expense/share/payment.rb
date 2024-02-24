# frozen_string_literal: true

class Expense::Share::Payment < ApplicationRecord
  belongs_to :expense_share, class_name: 'Expense::Share'
  belongs_to :payment_method
  has_one_attached :proof

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :proof, presence: true
end