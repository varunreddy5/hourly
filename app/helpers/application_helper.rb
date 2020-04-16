module ApplicationHelper
  
  include Pagy::Frontend
  
  def user_avatar(user, size=40)
    if user.avatar.attached?
     image_tag user.avatar.variant(resize: "#{size}x#{size}!"), class: "rounded-circle"
    else
      image_tag "user.jpg", size: "#{size}x#{size}", class: "rounded-circle user-avatar"
    end
  end

  
end
