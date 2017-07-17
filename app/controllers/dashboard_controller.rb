class DashboardController < ApplicationController
  def index
    user_signed_in?
    authenticate_user!
    @meals = current_user.meals.limit(4)
    @symptoms = current_user.symptoms.limit(3)
  end
end
