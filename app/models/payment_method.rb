# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  belongs_to :user
  has_many :payments, class_name: 'Expense::Payment'

  validates :name, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }

  enum method_type: { cash: 'cash', bank_transfer: 'bank_transfer', exchange: 'exchange' }
  enum payment_provider: { internal: 'internal', mastercard: 'mastercard', visa: 'visa', amex: 'amex' }
end
