class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # Next we need to lookup the user if the record is present in the database else we need to create a new user
    service = Service.where(provider: auth.provider, uid: auth.uid).first
    if service.present?
      user = service.user
    else
      user = User.new(
        email: auth.info.email,
        name: auth.info.name,
        username: auth.info.email.split('@')[0],
        password: Devise.friendly_token[0, 20]
      )
      if user.save
        user.services.create(
          provider: auth.provider,
          uid: auth.uid,
          expires_at: Time.at(auth.credentials.expires_at),
          access_token: auth.credentials.token
        )
      end
    end
    sign_in_and_redirect user, event: :authentication
    set_flash_message :notice, :success, kind: "Facebook"
  end

  def auth
    request.env['omniauth.auth']
  end
end