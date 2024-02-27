# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expenses::Shares::PaymentsController, type: :controller do
  let(:user) { create(:user) }
  let(:expense_share) { create(:expense_share) }
  let(:payment_params) do
    {
      amount: 100,
      proof: fixture_file_upload(Rails.root.join('spec', 'support', 'files', 'test_image.jpg'), 'image/jpg')
    }
  end

  before do
    sign_in user
  end

  describe '#create' do
    context 'when payment is successful' do
      it 'creates a new payment and redirects to root path with a success message' do
        post :create, params: { share_id: expense_share.id, payment: payment_params }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Payment created')
      end
    end

    context 'when payment fails' do
      before do
        allow(::Expenses::Shares::Payments::Create).to receive(:call).and_return(double(success?: false, errors: double(full_messages: ['Error message'])))
      end

      it 'does not create a payment and redirects to root path with an error message' do
        post :create, params: { share_id: expense_share.id, payment: payment_params }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Error message')
      end
    end

    context 'when proof is not provided' do
      it 'does not create a payment and redirects to root path with an error message' do
        payment_params.delete(:proof)

        post :create, params: { share_id: expense_share.id, payment: payment_params }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to include('Proof can\'t be blank')
      end
    end
  end
end
