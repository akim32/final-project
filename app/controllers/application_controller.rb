class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #FIX THIS PROBLEM -> CSRF AUTHENTICATION ERROR
  #protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
    protected

  def configure_permitted_parameters
  # Permit the `subscribe_newsletter` parameter along with the other
  # sign up parameters.
  devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
  
end
