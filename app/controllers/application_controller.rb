class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # This allows the :role parameter to reach the database
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end