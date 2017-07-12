class IngredientSymptom < ApplicationRecord
  belongs_to :ingredient
  belongs_to :symptom
end
