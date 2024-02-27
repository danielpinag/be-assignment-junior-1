# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:valid_attributes) do
    {
      amount: 100,
      name: 'Groceries',
      description: 'Weekly groceries',
      equally_shared: true,
      users_params: [
        { user_id: user.id, amount: 50 },
        { user_id: user_two.id, amount: 50 }
      ]
    }
  end
  let!(:invalid_attributes) do
    {
      amount: nil,
      name: nil,
      description: nil,
      equally_shared: nil,
      users_params: nil
    }
  end

  before do
    sign_in(user)
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Expense' do
        expect {
          post :create, params: { expense: valid_attributes }
        }.to change(Expense, :count).by(1)
      end

      it 'redirects to the root path with a success notice' do
        post :create, params: { expense: valid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Expense created')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Expense' do
        expect {
          post :create, params: { expense: invalid_attributes }
        }.to change(Expense, :count).by(0)
      end

      it 'redirects to the root path with an error alert' do
        post :create, params: { expense: invalid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
