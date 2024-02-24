# frozen_string_literal: true

class CreateExpenseShares < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_shares do |t|
      t.references :expense, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
