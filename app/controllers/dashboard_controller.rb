class DashboardController < ApplicationController
  def index
    user_signed_in?
    authenticate_user!
    @meals = current_user.meals.limit(5)
  end
end
