class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients

  validates_presence_of :meal_type, :description
  validates :description, length: { maximum: 30 }
 
  def parse_ingredients(new_ingredients)
    new_ingredients.split(',').each do |ingredient|
      ingredients << Ingredient.find_or_create_by(name: ingredient.strip.downcase)
    end
  end

  def ingredients_attributes=(ingredients_attributes)
    return if ingredients_attributes.dig('0', 'name').blank?
    new_ingredients = ingredients_attributes.dig('0', 'name')
    if new_ingredients.include?(',')
      parse_ingredients(new_ingredients)
    else
      ingredient = Ingredient.find_or_create_by(ingredients_attributes)
      self.ingredients << ingredient
    end
  end
end
