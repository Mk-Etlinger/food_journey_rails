class Reaction < ApplicationRecord
  belongs_to :ingredient
  belongs_to :symptom
  has_many :reaction_logs
end
