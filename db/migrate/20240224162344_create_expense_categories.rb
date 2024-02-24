# frozen_string_literal: true

class CreateExpenseCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_categories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_index :expense_categories, %i[user_id name], unique: true
  end
end
