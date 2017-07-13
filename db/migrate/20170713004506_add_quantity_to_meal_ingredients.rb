class AddQuantityToMealIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :meal_ingredients, :quantity, :string
  end
end
