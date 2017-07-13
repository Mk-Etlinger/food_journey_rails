class MealsController < ApplicationController

  def new
    @meal = Meal.new
    @ingredients = Ingredient.all
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to dashboard_path
    else
      
    end
  end

  def show
    set_meal
  end

  def edit
    set_meal
  end

  def update
    set_meal
    if @meal.update(meal_params)
      redirect_to dashboard_path
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    if @meal.user == current_user
      @meal.ingredients.clear
      @meal.destroy
      redirect_to dashboard_path
    else
      redirect_back fallback_location: root_path
    end
    
  end

  private

  def set_meal
    @meal = Meal.find_by(id: params[:id])
  end

  def meal_params
    params.require(:meal).permit(:meal_type, :description, ingredient_ids: [], ingredients_attributes: [:name])
  end
  
end
