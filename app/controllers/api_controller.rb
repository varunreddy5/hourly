class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_default_format
  before_action :authenticate_token!

  def set_default_format 
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find_by_username(payload['sub'])
    # p @current_user
  rescue JWT::ExpiredSignature
    render json: { errors: ['Auth Token has expired']}, status: :unauthorized
  rescue JWT::DecodeError
    render json: { errors: ['Invalid Auth Token']}, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization','').split(' ').last
  end
end