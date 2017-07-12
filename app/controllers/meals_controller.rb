class MealsController < ApplicationController

  def new
    @meal = Meal.new
    @ingredients = Ingredient.all
  end

  def create
    @meal = current_user.meals.build(meal_params)
    # @new_ingredients = params[:ingredients][:name]

    

    binding.pry
    if @meal.save
      redirect_to dashboard_path
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
