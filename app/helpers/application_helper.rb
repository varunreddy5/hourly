module ApplicationHelper
  # include SessionsHelper
  include Pagy::Frontend

  def user_avatar(user, size=30)
    if user.avatar.attached?
     image_tag user.avatar.variant(resize: "#{size}x#{size}!"), class: "rounded-circle"
    else
      image_tag "user.svg", size: "#{size}x#{size}", class: "rounded-circle"
    end
  end
end
