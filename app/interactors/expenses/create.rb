# frozen_string_literal: true

class Expenses::Create < ::ApplicationInteractor
  before do
    context.equally_shared = context.expense_params.delete(:equally_shared)
    context.users_params = context.expense_params.delete(:users_params)
  end

  def call
    category_id = if context.user.expense_categories.empty?
                    # TODO - Add POST /expense_categories to create a new category
                    ExpenseCategory.create!(name: 'General', description: 'General expenses', user_id: context.user.id).id
                  else
                    context.user.expense_categories.find_by(name: 'General').id
                  end


    context.expense_params[:expense_shares_attributes] = if context.equally_shared
                                                           context.users_params&.map do |params|
                                                             { user_id: params[:user_id], amount: context.expense_params[:amount].to_f / context.users_params.size.to_f }
                                                           end
                                                         else
                                                           context.users_params
                                                         end


    expense = Expense.new(context.expense_params.merge(owner_id: context.user.id, category_id: category_id).compact)
    if expense.save
      context.expense = expense
    else
      context.fail!(errors: expense.errors)
    end
  end
end
