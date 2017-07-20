class SymptomsController < ApplicationController
  before_action :user_signed_in?, :authenticate_user!
  before_action :set_symptom, only: [:show, :edit, :update, :destroy]

  def index
    @symptoms = current_user.symptoms
  end
  
  def new
    @symptom = Symptom.new
  end
  
  def create
    redirect_to nested_new_meal_path(current_user), alert: no_meals_message and return if valid_meals.empty?
    @symptom = current_user.symptoms.build(symptom_params)

    if @symptom.save
      redirect_to symptom_path(@symptom)
    else
      render :new
    end
  end

  def show
    @reaction = @symptom.reactions.first
  end

  def edit
  end

  def update
    if user_authorized? && @symptom.update(symptom_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    if user_authorized?
      @symptom.ingredients.clear
      @symptom.destroy
      redirect_to dashboard_path
    else
      redirect_back fallback_location: root_path
    end
  end

  private

  def set_symptom
    @symptom = Symptom.find_by(id: params[:id])
  end

   def symptom_params
    params.require(:symptom).permit(:description,
                                    ingredients_attributes: [:current_user_id, :hours_elapsed, :occurred_at],
                                    reactions_attributes: [:severity, :stress_level, :notes],
                                    reaction_logs: [:occurred_at])
  end

  def user_authorized?
    @symptom.user == current_user
  end

  def valid_meals
    hours = symptom_params['ingredients_attributes']['0']['occurred_at'].to_f
    occurred_at = Time.current.ago(hours.hour)
    Meal.for_user(current_user).created_within(occurred_at - 3.day, occurred_at)
  end

  def no_meals_message
    "Please create a meal first. Currently you have no meals within the selected time period"
  end

end
