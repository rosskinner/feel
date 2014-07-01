module ApplicationHelper

  def smartnav_right
    links = ''
    if @current_user.try(:is_admin)
      links += "<li class = 'nav_right'>" + link_to(image_tag("users_icon.png", :class => "icon"), users_path) + "</li>"
    end
    if @current_user.present?
      links += "<li class = 'nav_right'>#{ link_to(image_tag("setting_icon.png", :class => "icon") , user_path(@current_user)) }</li>"
      links += "<li class = 'nav_right'>"
      links += link_to(image_tag("logout_icon.png", :class => "icon") + image_tag(@current_user.avatar, :class => "avatar icon") + @current_user.username, login_path, :data => {:method => :delete, :confirm => 'Really logout?'})
      links += "</li>"
    end
      links
  end

  def sign_up
    links = ''
      if !@current_user.present?
        links += "#{ link_to('Sign up', new_user_path) }"
      end
      links
  end
end

