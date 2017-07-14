class Ingredient < ApplicationRecord
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  has_many :reactions
  has_many :symptoms, through: :reactions

  validates_presence_of :name
  validates :name, format: { with: /[a-zA-Z,]/ }
end
