module SessionsHelper

  def clear_already_logged_in_alert
    flash[:alert].clear if flash[:alert] = "You are already signed in."
  end
  
end
