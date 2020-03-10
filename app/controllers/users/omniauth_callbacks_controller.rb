class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_service
  before_action :set_user
  attr_reader :service, :user
  def facebook
    # Next we need to lookup the user if the record is present in the database else we need to create a new user
    handle_auth("Facebook")
  end

  def github
    handle_auth("Github")
  end

  def twitter
    handle_auth("Twitter")
  end

  private 
  def handle_auth(kind)
    if service.present?
      service.update(service_attr)
    else
      user.services.create(service_attr)
    end

    if user_signed_in?
      flash[:notice] = "Your #{kind} account was connected"
      redirect_to edit_user_registration_path
    else
      sign_in_and_redirect user, event: :authentication
      set_flash_message :notice, :success, kind: kind
    end
  end
  def auth
    request.env['omniauth.auth']
  end
  def set_service
    @service = Service.where(provider: auth.provider, uid: auth.uid).first
  end

  # This validates if user already have an account associated with either facebook or github
  def set_user
    if user_signed_in?  # If user is signed in
      @user = current_user
    elsif service.present? # If user is not signed in and service is present
      @user = service.user
    elsif User.where(email: auth.info.email).any? # If the user is not signed in and an account already exists
        flash[:alert] = "An account with this email already exists. Please signin with that account before connecting your #{auth.provider} account"
        redirect_to new_user_session_path
    else
      username = auth.info.nickname.present? ? auth.info.nickname : auth.info.email.split('@')[0]
      @user = User.new(     # Create a new user with auth credentials
        email: auth.info.email, 
        name: auth.info.name,
        username: username,
        password: Devise.friendly_token[0, 20]
      )
      if !@user.save
        flash[:alert] = "Your email or username of your #{auth.provider} account is not accessible. Please choose a different login method"
        redirect_to new_user_session_path
      end
    end
  end
  def service_attr
    expires_at = auth.credentials.expires_at.present? ? Time.at(auth.credentials.expires_at) : nil
    {
      provider: auth.provider,
      uid: auth.uid,
      expires_at: expires_at,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
    }
  end
  
end