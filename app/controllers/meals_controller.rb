class MealsController < ApplicationController
  before_action :user_signed_in?, :authenticate_user!
  before_action :set_meal, only: [:edit, :update, :destroy]

  def new
    @meal = Meal.new
    @ingredients = Ingredient.all
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    if user_authorized?
      render :edit
    else
      redirect_to dashboard_path
    end
  end

  def update
    if user_authorized? && @meal.update(meal_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end
  # test destroy to make sure ingredients remain in db(do associations remain?)
  def destroy
    if user_authorized?
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

  def user_authorized?
    @meal.user == current_user
  end

end
