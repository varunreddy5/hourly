class SessionsController < ApplicationController
  # def new
  #   if logged_in?
  #     redirect_to current_user
  #   end
  # end
  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && !!user.authenticate(params[:session][:password])
  #     log_in user
  #     remember user
  #     redirect_to user
  #   else
  #     flash[:danger] = 'Invalid email/password. Try Again!'
  #     render 'new'
  #   end
  # end
  # def destroy
  #   log_out if logged_in?
  #   redirect_to root_path
  # end
end
