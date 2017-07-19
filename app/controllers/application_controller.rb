class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || dashboard_path
  end

  def index
    render "landing/index"
  end

  # def set_instance_variable
  #   controller_name = params['controller']
  #   controller_name.chop!
  #   model_name = controller_name.capitalize
  #   instance_variable_set('@' + controller_name, model_name.find_by(id: params[:id]))
  # end
end
