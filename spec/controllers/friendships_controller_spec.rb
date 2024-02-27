require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friendship) { create(:friendship, user: user, friend: friend) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns the current user friends to @friends' do
      get :index
      expect(assigns(:friends)).to eq(user.friends)
    end

    it 'assigns the current user sent friend requests to @friend_requests_sent' do
      get :index
      expect(assigns(:friend_requests_sent)).to eq(user.friend_requests_sent)
    end

    it 'assigns the current user received friend requests to @friend_requests_received' do
      get :index
      expect(assigns(:friend_requests_received)).to eq(user.friend_requests_received)
    end
  end

  describe 'POST #create' do
    context 'when the friend request is successful' do
      it 'redirects to the friendships path with a success notice' do
        post :create, params: { friendship: { friend_id: friend.id } }
        expect(response).to redirect_to(friendships_path)
        expect(flash[:notice]).to eq('Friend request sent')
      end
    end

    context 'when the friend request fails' do
      before do
        allow(Friendships::Create).to receive(:call).and_return(OpenStruct.new(success?: false, errors: OpenStruct.new(full_messages: ['Error message'])))
      end

      it 'redirects to the friendships path with an error alert' do
        post :create, params: { friendship: { friend_id: friend.id } }
        expect(response).to redirect_to(friendships_path)
        expect(flash[:alert]).to eq('Error message')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the friendship' do
      delete :destroy, params: { id: friendship.id }
      expect(Friendship.exists?(friendship.id)).to be_falsey
    end
  end

  describe 'POST #accept' do
    it 'accepts the friendship' do
      post :accept, params: { id: friendship.id }
      expect(friendship.reload.accepted?).to be_truthy
    end
  end
end
