# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expense_shares, class_name: 'Expense::Share'
  has_many :expenses, through: :expense_shares
  has_many :owned_expenses, class_name: 'Expense', foreign_key: 'owner_id'
  has_many :expense_categories
  has_many :payment_methods
  has_many :friend_requests_sent, -> { pending }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friend_requests_received, -> { pending }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friendships, -> { accepted }, class_name: 'Friendship', foreign_key: 'user_id'

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :mobile_number, presence: true, length: { minimum: 10, maximum: 15 }

  def friends
    User.joins(:friendships).where('friendships.user_id = ? OR friendships.friend_id = ?', id, id)
  end
end
