# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe 'validations' do
    subject { build(:payment_method, attributes) }

    context 'when user is nil' do
      let(:attributes) { { user: nil } }
      it { is_expected.to validate_presence_of(:user) }
    end

    context 'when name is nil' do
      let(:attributes) { { name: nil } }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when name is not unique per user' do
      let(:user) { create(:user) }
      let!(:existing_payment_method) { create(:payment_method, user: user, name: 'Visa') }
      let(:attributes) { { user: user, name: 'Visa' } }
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
    end

    context 'when name length is more than 50 characters' do
      let(:attributes) { { name: 'a' * 51 } }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end

    context 'when description length is more than 255 characters' do
      let(:attributes) { { description: 'a' * 256 } }
      it { is_expected.to validate_length_of(:description).is_at_most(255) }
    end

    context 'when method_type is not a valid value' do
      let(:attributes) { { method_type: 'invalid_method_type' } }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when payment_provider is not a valid value' do
      let(:attributes) { { payment_provider: 'invalid_payment_provider' } }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:payments).class_name('Expense::Share::Payment') }
  end
end
