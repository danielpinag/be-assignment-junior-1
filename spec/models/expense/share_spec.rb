# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense::Share, type: :model do
  describe 'validations' do
    subject { build(:expense_share, attributes) }

    context 'when amount is nil' do
      let(:attributes) { { amount: nil } }
      it { is_expected.to validate_presence_of(:amount) }
    end

    context 'when amount is not a number' do
      let(:attributes) { { amount: 'not a number' } }
      it { is_expected.to validate_numericality_of(:amount) }
    end

    context 'when amount is less than or equal to 0' do
      let(:attributes) { { amount: 0 } }
      it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    end

    context 'when status is not a valid value' do
      let(:attributes) { { status: 'invalid_status' } }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:expense) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:payments).class_name('Expense::Share::Payment') }
  end
end
