class DashboardController < ApplicationController
  def index
    user_signed_in?
    authenticate_user!
    @meals = current_user.meals.order(created_at: :desc).limit(4)
    @symptoms = current_user.symptoms.order(created_at: :desc).limit(3)
  end
end
