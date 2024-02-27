# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @friend_requests_sent = current_user.friend_requests_sent.includes(:friend)
    @friend_requests_received = current_user.friend_requests_received.includes(:user)
  end

  def create
    result = Friendships::Create.call(
      user: current_user,
      friend_id: params[:friend_id]
    )

    if result.success?
      redirect_to friendships_path, notice: 'Friend request sent'
    else
      redirect_to friendships_path, alert: result.errors.full_messages.join(', ')
    end
  end

  def destroy
    friendship.destroy!
  end

  def accept
    friendship.accepted!
  end

  private

  def friendship
    @friendship ||= Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
