# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }, index: true
      t.references :category, null: false, foreign_key: { to_table: :expense_categories }, index: true
      t.string :name, null: false
      t.string :description
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
