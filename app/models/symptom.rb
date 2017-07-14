class Symptom < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :ingredients, through: :reactions
  has_many :reaction_logs

  def reactions_attributes=(reactions_attribute_set)
    reactions_attribute_set.values.each do |reactions_attribute|
      binding.pry
      self.reactions.build(reactions_attribute) # check if this saves. idk if it does
    end
  end

end
