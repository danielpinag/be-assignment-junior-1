# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    subject { build(:friendship, attributes) }

    context 'when user is same as friend' do
      let(:attributes) { { user: user, friend: user } }
      let(:user) { create(:user) }
      it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:friend_id) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end
end
