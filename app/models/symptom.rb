class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, through: :reactions

  def ingredients_attributes=(ingredients_attributes)
 
  end
end
