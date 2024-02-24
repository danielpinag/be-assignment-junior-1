# frozen_string_literal: true

FactoryBot.define do
  factory :expense_share, class: 'Expense::Share' do
    association :expense
    association :user
    amount { Faker::Number.decimal(l_digits: 2) }
    status { 'pending' }
  end
end
