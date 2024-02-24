# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense::Share::Payment, type: :model do
  describe 'validations' do
    subject { build(:expense_share_payment, attributes) }

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

    context 'when proof is not attached' do
      subject { build(:expense_share_payment) }
      before { subject.proof.detach }
      it { is_expected.to validate_presence_of(:proof) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:expense_share) }
    it { is_expected.to belong_to(:payment_method) }
    it { is_expected.to have_one_attached(:proof) }
  end
end
