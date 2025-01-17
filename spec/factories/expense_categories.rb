# frozen_string_literal: true

FactoryBot.define do
  factory :expense_category do
    user { association :user }
    name { Faker::Commerce.department }
    description { Faker::Lorem.sentence }
  end
end
