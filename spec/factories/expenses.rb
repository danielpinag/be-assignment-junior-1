# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    owner { association :user }
    category { association :expense_category }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2) }
    status { 'pending' }
  end
end
