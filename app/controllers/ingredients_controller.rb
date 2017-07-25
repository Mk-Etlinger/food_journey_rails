class IngredientsController < ApplicationController

  def index
    user_signed_in?
    authenticate_user!
    @meal = Meal.find_by(id: params[:meal_id])
  end

  def safe
    @ingredient = Ingredient.new
  end

  def mark_safe
    safe_ingredients = ingredient_params[:id]
    @ingredients = Ingredient.where(id: safe_ingredients)
    @ingredients.each { |ingredient| ingredient.update(safe: true) }
    redirect_to dashboard_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(id: [])
  end

  def set_ingredient
    @ingredient = Ingredient.find_by(id: params[])
  end
  
end
