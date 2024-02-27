# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:current_user) { create(:user) }

  let!(:owned_expense) { create(:expense, owner: current_user, amount: 40) }
  let!(:owned_share_to_receive) { create(:expense_share, user: user, expense: owned_expense, amount: 20) }
  let!(:owned_share_to_pay) { create(:expense_share, user: user, expense: shared_expense, amount: 20) }

  let!(:shared_expense) { create(:expense, owner: user, amount: 40) }
  let!(:shared_expense_share) { create(:expense_share, user: user, expense: shared_expense, amount: 20) }
  let!(:shared_expense_to_pay) { create(:expense_share, user: current_user, expense: shared_expense, amount: 20) }

  describe 'GET #show' do
    context 'when user has expenses to pay and receive' do
      before do
        sign_in current_user
        get :show, params: { id: user.id }
      end

      it 'assigns @expenses_to_pay' do
        expect(assigns(:expenses_to_pay)).to eq([shared_expense_to_pay])
      end

      it 'assigns @expenses_to_receive' do
        expect(assigns(:expenses_to_receive)).to eq([owned_share_to_receive])
      end

      it 'assigns @expenses_to_pay_total' do
        expect(assigns(:expenses_to_pay_total)).to eq(shared_expense_to_pay.remaining_amount)
      end

      it 'assigns @expenses_to_receive_total' do
        expect(assigns(:expenses_to_receive_total)).to eq(owned_share_to_receive.remaining_amount)
      end
    end
  end
end
