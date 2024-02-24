# frozen_string_literal: true

FactoryBot.define do
  factory :payment_method do
    user { association :user }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    method_type { 'cash' }
    payment_provider { 'internal' }
  end
end