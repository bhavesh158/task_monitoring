class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def to_s
    team_name
  end

  def after_sign_in_path_for(resource)
    if resource.class == AdminUser
      admin_root_path
    else
      home_index_path
    end
  end

end
