class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :description
      t.string :meal_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
