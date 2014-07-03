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
        links += "#{ link_to('Sign up', new_user_path, :style => "color:#FFF") }"
      end
      links
  end

  def login
    links = ''
      if !@current_user.present?
        links += "#{ link_to('login', root_path, :style => "color:#FFF") }"
      end
      links
  end

  def smartnav_left
    if @current_user.present?
      "<span>
        #{link_to('Edit User',edit_user_path(@current_user))} |
      </span>
      <span>
        #{link_to('Add Location',locations_path(@current_user))}
      </span>"
    end
  end
end

