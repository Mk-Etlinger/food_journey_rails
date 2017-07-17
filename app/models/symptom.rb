class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, -> { distinct }, through: :reactions
  has_many :reaction_logs, through: :reactions

  def reactions_attributes=(reaction_attributes)
    reaction_attributes.values.each do |attribute|
      self.reactions.each do |reaction|
        reaction.update(attribute)
      end
    end
  
  end

  def ingredients_attributes=(attr)
    return if self.persisted?
    self.user_id = attr.dig('0', 'current_user_id')
    meals = Meal.for_user(user).created_after((Time.now - 3.day))
    binding.pry
    meals.each do |meal|
      meal.ingredients.each do |ingredient|
        self.ingredients << ingredient
        binding.pry
      end
    end
    save
  end  

  def reaction_logs=(attributes)
    hours_ago = attributes['occurred_at'].to_i
    increment = attributes['increment']
    attributes['occurred_at'] = Time.now - hours_ago.to_i.hour
    self.reactions.each do |reaction|
      reaction.reaction_logs.create(attributes)
    end
  end

end
