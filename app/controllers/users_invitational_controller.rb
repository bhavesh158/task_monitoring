class UsersInvitationalControllerController < ApplicationController
  
  def edit
    render :edit, :layout => false
  end

  def update
    self.resource = resource_class.accept_invitation!(resource_params)
 
    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active                                                                                        
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
 
      redirect_to '/profile', :alert => "Welcome! Please fill out your profile and upload a headshot." 
    else
      respond_with_navigational(resource){ render :edit, :layout => false }
    end
  end
  
end
