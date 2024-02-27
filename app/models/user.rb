# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expense_shares, class_name: 'Expense::Share'
  has_many :expenses, through: :expense_shares
  has_many :owned_expenses, class_name: 'Expense', foreign_key: 'owner_id'
  has_many :expense_categories
  has_many :payment_methods
  has_many :friend_requests_sent, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friend_requests_received, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :encrypted_password, presence: true
  validates :name, presence: true
  validates :mobile_number, presence: true, length: { minimum: 10, maximum: 15 }

  def friends
    User.joins('INNER JOIN friendships ON users.id = friendships.user_id OR users.id = friendships.friend_id')
        .where('friendships.status = ? AND (friendships.user_id = ? OR friendships.friend_id = ?)', 'accepted', id, id).where.not(id: id)
  end

  def friendship_with(user)
    Friendship.where('(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)', id, user.id, user.id, id).first
  end

  def pending_friend_requests_sent
    friend_requests_sent.pending
  end

  def pending_friend_requests_received
    friend_requests_received.pending
  end

  def expense_shares_to_pay
    expense_shares.where(status: [:pending, :partially_paid])
                  .where.not(expense: owned_expenses)
  end

  def expense_shares_to_receive_from(user)
    user.expense_shares_to_pay.where(user: self)
  end
end
