# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friendship_is_not_duplicated
  validate :user_is_not_equal_to_friend

  enum status: { pending: 'pending', accepted: 'accepted' }

  private

  def friendship_is_not_duplicated
    return unless Friendship.where(user: user, friend: friend)
                            .or(Friendship.where(user: friend, friend: user)).where.not(id: id).exists?

    errors.add(:friend, 'is already a friend')
  end

  def user_is_not_equal_to_friend
    errors.add(:friend, 'cannot be the same as the user') if user == friend
  end
end
