# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id }
  validate :user_is_not_equal_to_friend

  enum status: { pending: 'pending', accepted: 'accepted' }

  private

  def user_is_not_equal_to_friend
    errors.add(:friend, 'cannot be the same as the user') if user == friend
  end
end
