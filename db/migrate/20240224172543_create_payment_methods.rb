# frozen_string_literal: true

class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name, null: false
      t.string :description
      t.string :method_type
      t.string :payment_provider, default: 'internal'

      t.timestamps
    end
  end
end
