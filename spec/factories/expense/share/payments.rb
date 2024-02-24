# frozen_string_literal: true

FactoryBot.define do
  factory :expense_share_payment, class: 'Expense::Share::Payment' do
    expense_share { association :expense_share }
    payment_method { association :payment_method }
    amount { Faker::Number.decimal(l_digits: 2) }
    after(:build) do |payment|
      payment.proof.attach(
        io: File.open(Rails.root.join('spec', 'support', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end