# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user { association :user }
    friend { association :friend, factory: :user }
    status { 'pending' }
  end
end