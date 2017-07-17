class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, -> { distinct }, through: :reactions
  has_many :reaction_logs, through: :reactions

  def reactions_attributes=(reaction_attributes)
    reaction_attributes.values.each do |attribute|
      self.reactions.each do |reaction|
        binding.pry
        reaction.update(attribute)
      end
    end
  
  end

  # still need to make associations based on dynamic entry of elapsed time
  def ingredients_attributes=(attr)
    return if self.persisted? # currently not allowing this to update
    self.user_id = attr.dig('0', 'current_user_id')
    meals = Meal.for_user(user).created_after((Time.now - 3.day))
    meals.each do |meal|
      meal.ingredients.each do |ingredient|
        self.ingredients << ingredient
      end
    end
    # save
  end

  def reaction_logs=(attributes)
    hours_ago = attributes['occurred_at'].to_i
    # increment = attributes['increment']
    attributes['occurred_at'] = Time.now - hours_ago.hour
    self.reactions.each do |reaction|
      reaction.reaction_logs.create(attributes)
    end
  end

end
