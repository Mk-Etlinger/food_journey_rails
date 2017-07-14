class SymptomsController < ApplicationController

  def index
    @symptoms = Symptom.all
  end
  
  def new
    @symptom = Symptom.new
    @reaction_log = ReactionLog.new
  end
  
  def create
    binding.pry
  end

  private

  def set_symptom
    @symptom = Symptom.find_by(id: params[:id])
  end
  
  def symptom_params
    params.require(:symptom).permit(:description, :reaction_log[:severity][])
  end
  
end
