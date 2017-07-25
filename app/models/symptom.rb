class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, -> { distinct }, through: :reactions
  has_many :reaction_logs, through: :reactions

  validates_presence_of :description

  def reactions_attributes=(reaction_attributes)
    reaction_attributes.values.each do |attribute|
      self.reactions.each do |reaction|
        reaction.update(attribute)
      end
    end
  end

  def ingredients_attributes=(attributes)
    return if self.persisted? # currently not allowing this to update
    set_user_id(attributes) && set_occurred_at(attributes)
    set_meals_within_three_days
    @meals.each do |meal|
      meal.ingredients.each do |ingredient|
        self.ingredients << ingredient
      end
    end
  end

  def reaction_logs=(attributes)
    self.reactions.each do |reaction|
      reaction.reaction_logs.create(occurred_at: @occurred_at)
    end
  end

  def set_meals_within_three_days
    @meals = Meal.for_user(user).created_within(@occurred_at - 3.day, @occurred_at)
  end

  def set_occurred_at(attributes)
    hours = attributes['0']['occurred_at'].to_f
    @occurred_at = Time.current.ago(hours.hour)
  end

  def set_user_id(attributes)
    self.user_id = attributes.dig('0', 'current_user_id')
  end
end
