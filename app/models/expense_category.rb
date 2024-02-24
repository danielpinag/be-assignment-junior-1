# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  belongs_to :user
  has_many :expenses

  validates :user, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 255 }
end
