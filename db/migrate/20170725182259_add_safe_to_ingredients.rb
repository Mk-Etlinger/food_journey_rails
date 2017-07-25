class AddSafeToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :safe, :boolean, default: false
  end
end
