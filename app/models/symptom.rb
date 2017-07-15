class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, through: :reactions
  has_many :reaction_logs

  def reactions_attributes=(reaction_attributes)
    reaction_attributes.values.each do |attribute|
      binding.pry
      # you have to iterate over reactions? and find the associated reaction
      self.reactions.each do |reaction|
        binding.pry
        reaction.update(attribute)
      end
    end
  
  end

  def ingredients_attributes=(attr)
    self.user_id = attr.dig('0', 'current_user_id')
    meals = Meal.for_user(user).where("created_at > ?",(Time.now - 3.day))
    meals.each do |meal|
      meal.ingredients.each do |ingredient|
        binding.pry
        self.ingredients << ingredient
      end
    end
    save
  end  

  # def reaction_logs=(attributes)
  #   self.reactions.each do |reaction|
  #     reaction.reaction_logs.create(attributes)
  #   end
  # end

  # def associate_ingredients_attributes
  #   meals = Meal.for_user(self.user).where("created_at > ?",(Time.now - 3.day))
  #   meals.each { |meal| self.ingredients << meal.ingredients }
  #  meals = Meal.for_user(self.user).where("created_at > ?",(Time.now - 3.day))
  #   meals.each do |meal|
  #     meal.ingredients.each do |ingredient|
  #       binding.pry
  #       self.ingredients << ingredient
  #       self.reactions.build(reaction_attributes['0'])
  #     end
  #   end
  # end

end
