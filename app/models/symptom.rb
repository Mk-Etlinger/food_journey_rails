class Symptom < ApplicationRecord
  belongs_to :user
  has_many :ingredient_symptoms
  has_many :symptoms, through: :ingredient_symptoms
end
