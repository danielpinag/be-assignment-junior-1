# frozen_string_literal: true

class Friendships::Create < ApplicationInteractor
  def call
    friendship = context.user.friendships.build(friend_id: context.friend_id)

    if friendship.save
      context.friendship = friendship
    else
      context.fail!(errors: friendship.errors)
    end
  end
end