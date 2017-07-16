class IngredientsController < ApplicationController

  def index
    user_signed_in?
    authenticate_user!
    @meal = Meal.find_by(id: params[:meal_id])
  end
  
end
