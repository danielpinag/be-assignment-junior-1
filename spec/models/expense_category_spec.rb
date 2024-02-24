# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::ExpenseCategory, type: :model do
  describe 'validations' do
    subject { build(:expense_category, attributes) }

    context 'when user is nil' do
      let(:attributes) { { user: nil } }
      it { is_expected.to validate_presence_of(:user) }
    end

    context 'when name is nil' do
      let(:attributes) { { name: nil } }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when name is too long' do
      let(:attributes) { { name: 'a' * 51 } }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end

    context 'when description is nil' do
      let(:attributes) { { description: nil } }
      it { is_expected.to validate_presence_of(:description) }
    end

    context 'when description is too long' do
      let(:attributes) { { description: 'a' * 256 } }
      it { is_expected.to validate_length_of(:description).is_at_most(255) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:expenses) }
  end
end