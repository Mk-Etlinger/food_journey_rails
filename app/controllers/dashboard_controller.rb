class DashboardController < ApplicationController
  def index
    @meals = current_user.meals.limit(5)
  end
end
