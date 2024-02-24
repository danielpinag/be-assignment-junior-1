# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expense_shares
  has_many :expenses, through: :expense_shares
  has_many :expense_categories
  has_many :payment_methods

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :mobile_number, presence: true, length: { minimum: 10, maximum: 15 }
end
