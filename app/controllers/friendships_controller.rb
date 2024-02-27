# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @friend_requests_sent = current_user.pending_friend_requests_sent
    @friend_requests_received = current_user.pending_friend_requests_received
  end

  def create
    result = Friendships::Create.call(
      user: current_user,
      friend_id: friendship_params[:friend_id]
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
    params.require(:friendship).permit(:friend_id)
  end
end
