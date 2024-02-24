# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :expense_share, null: false, foreign_key: true, index: true
      t.references :payment_method, null: false, foreign_key: true, index: true
      t.decimal :amount, precision: 10, scale: 2, null: false


      t.timestamps
    end
  end
end
