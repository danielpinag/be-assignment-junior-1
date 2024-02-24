# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user, attributes) }

    context 'when email is nil' do
      let(:attributes) { { email: nil } }
      it { is_expected.to validate_presence_of(:email) }
    end

    context 'when email is not unique' do
      let(:attributes) { { email: 'test@example.com' } }
      before { create(:user, email: 'test@example.com') }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end

    context 'when encrypted_password is nil' do
      let(:attributes) { { encrypted_password: nil } }
      it { is_expected.to validate_presence_of(:encrypted_password) }
    end

    context 'when name is nil' do
      let(:attributes) { { name: nil } }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when mobile_number is nil' do
      let(:attributes) { { mobile_number: nil } }
      it { is_expected.to validate_presence_of(:mobile_number) }
    end

    context 'when mobile_number is too short' do
      let(:attributes) { { mobile_number: '123' } }
      it { is_expected.to validate_length_of(:mobile_number).is_at_least(10) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:expense_shares) }
    it { is_expected.to have_many(:expenses) }
    it { is_expected.to have_many(:owned_expenses) }
    it { is_expected.to have_many(:expense_categories) }
    it { is_expected.to have_many(:payment_methods) }
  end
end