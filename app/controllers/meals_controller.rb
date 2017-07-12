class MealsController < ApplicationController

  def new
    @meal = Meal.new
    @ingredients = Ingredient.all
  end

  def create
    @meal = Meal.new(meal_params)
    binding.pry
    # @new_ingredients = params[:ingredients][:name]

    

    if @meal.save
      binding.pry
    else
      
    end
  end  

  private

  def set_meal

  end
  
  def meal_params
    params.require(:meal).permit(:meal_type, :description, ingredient_ids: [], ingredients_attributes: [:name])
  end
  
end
