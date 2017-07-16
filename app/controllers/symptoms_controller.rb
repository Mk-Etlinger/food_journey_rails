class SymptomsController < ApplicationController

  def index
    @symptoms = Symptom.all
  end
  
  def new
    @symptom = Symptom.new
    @reaction_log = ReactionLog.new
    @ingre
  end
  
  def create
    @symptom = current_user.symptoms.create(symptom_params)
    binding.pry

    if @symptom.save
      redirect_to symptom_path(@symptom)
    else
      render :new
    end
  end

  def show
    set_symptom
    @reaction = @symptom.reactions.first
  end
  

  private

  def set_symptom
    @symptom = Symptom.find_by(id: params[:id])
  end
  
  def symptom_params
    params.require(:symptom).permit(:description,  ingredients_attributes: [:current_user_id], reactions_attributes: [:severity, :stress_level, :notes], reaction_logs: [:occurred_at])
  end


end
