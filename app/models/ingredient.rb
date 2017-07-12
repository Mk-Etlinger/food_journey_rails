class Ingredient < ApplicationRecord
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  has_many :ingredient_symptoms
  has_many :ingredients, through: :ingredient_symptoms

  validates_presence_of :name
  validates :name, format: { with: /[a-zA-Z,]/ }
end
