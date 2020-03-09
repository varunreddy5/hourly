class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception
  # include ActionController::Live
  
  # protect_from_forgery prepend: true
  include Pagy::Backend
  # def logged_in_user
  #   unless logged_in?
  #     store_location
  #     flash[:danger] = "Please Login"
  #     redirect_to login_path
  #   end
  # end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username])
  end
end
