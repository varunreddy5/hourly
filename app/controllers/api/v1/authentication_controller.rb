class Api::V1::AuthenticationController < ApiController
  skip_before_action :set_default_format
  skip_before_action :authenticate_token!
  
  def new

  end

  def show
  
  end
  def create
    user = User.find(params[:user])
    @token = JsonWebToken.encode(sub: user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
# render :json => {token: JsonWebToken.encode(sub: user.id)} 
# render :json => { errors: ['Invalid email or password']} 