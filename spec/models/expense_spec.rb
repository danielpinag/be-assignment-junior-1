# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    subject { build(:expense, attributes) }

    context 'when owner is nil' do
      let(:attributes) { { owner: nil } }
      it { is_expected.to validate_presence_of(:owner) }
    end

    context 'when category is nil' do
      let(:attributes) { { category: nil } }
      it { is_expected.to validate_presence_of(:category) }
    end

    context 'when name is nil' do
      let(:attributes) { { name: nil } }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when amount is nil' do
      let(:attributes) { { amount: nil } }
      it { is_expected.to validate_presence_of(:amount) }
    end

    context 'when status is nil' do
      let(:attributes) { { status: nil } }
      it { is_expected.to validate_presence_of(:status) }
    end

    context 'when status is not a valid value' do
      let(:attributes) { { status: 'invalid_status' } }
      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('User') }
    it { is_expected.to belong_to(:category).class_name('ExpenseCategory') }
  end
end
