class SymptomsController < ApplicationController

  def index
    @symptoms = Symptom.all
  end
  
  def new
    @ingredients = Ingredient.joins(:meals).where(meals: { user_id: current_user.id })
    binding.pry
    @symptom = Symptom.new
  end
  
  def create

  end
  
end
