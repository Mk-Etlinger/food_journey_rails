class SymptomsController < ApplicationController

  def index
    @symptoms = Symptom.all
  end
  
  def new
    @symptom = Symptom.new
    @reaction_log = ReactionLog.new
  end
  
  def create
    if current_user
      @symptom = current_user.symptoms.create(symptom_params)
      redirect_to symptom_path(@symptom)
    else
      redirect_to root_path
    end
  end

  private

  def set_symptom
    @symptom = Symptom.find_by(id: params[:id])
  end
  
  def symptom_params
    # this now does not use the => since it has more then one
    params.require(:symptom).permit(:description, reactions_attributes: [:severity, :stress_level, :notes, :ingredient_id])
  end
  
end
