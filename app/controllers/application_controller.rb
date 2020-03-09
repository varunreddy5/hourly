class ApplicationController < ActionController::Base
  include ActionController::Live
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Login"
      redirect_to login_path
    end
  end
end
