# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    subject { build(:friendship, attributes) }

    context 'when friendship is duplicated' do
      let(:attributes) { { user: user, friend: friend } }
      let(:user) { create(:user) }
      let(:friend) { create(:user) }
      let!(:friendship) { create(:friendship, user: friend, friend: user) }
      it { is_expected.to be_invalid }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end
end
