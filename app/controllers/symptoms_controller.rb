class SymptomsController < ApplicationController
  before_action :user_signed_in?, :authenticate_user!
  before_action :set_symptom, only: [:show, :edit, :update, :destroy]

  def index
    @symptoms = current_user.symptoms
  end
  
  def new
    @symptom = Symptom.new
    @reaction_log = ReactionLog.new
  end
  
  def create
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
    set_symptom
    @reaction_log = @symptom.reaction_logs.first
  end

  def update
    if user_authorized? && @symptom.update(symptom_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end
  # test destroy to make sure ingredients remain in db(do associations remain?)
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
                                    ingredients_attributes: [:current_user_id, :hours_elapsed],
                                    reactions_attributes: [:severity, :stress_level, :notes],
                                    reaction_logs: [:occurred_at]
                                    )
  end

  def user_authorized?
    @symptom.user == current_user
  end

end
