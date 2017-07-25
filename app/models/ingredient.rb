class Ingredient < ApplicationRecord
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  has_many :reactions
  has_many :symptoms, through: :reactions # add unique: true?

  validates_presence_of :name
  validates :name, format: { with: /[a-zA-Z,]/ }

  after_update :update_reactions

  attr_accessor :current_user_id, :occurred_at

  def update_reactions
    self.symptoms.clear
  end
  
end
