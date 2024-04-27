class Users::InvitationsController < ApplicationController
    def new
      self.resource = invite_resource
      resource_invited = resource.errors.empty?
  
      yield resource if block_given?
  
      if resource_invited
        if is_flashing_format? && self.resource.invitation_sent_at
          set_flash_message :notice, :send_instructions, email: self.resource.email
        end
        respond_with resource, location: after_invite_path_for(resource)
      else
        respond_with_navigational(resource) { render :new }
      end
    end
  
    # GET /resource/invitation/accept?invitation_token=abcdef
    def accept_invitation
      self.resource = accept_resource
      resource.errors.empty? ? accept_invitation_success : accept_invitation_failure
    end
  
    # GET /resource/invitation/remove?invitation_token=abcdef
    def remove_invitation
      resource = User.find_by_invitation_token(params[:invitation_token], true)
      resource.destroy
      set_flash_message :notice, :invitation_removed
      redirect_to after_invite_path_for(resource)
    end
  
    protected
  
    def accept_invitation_success
      if resource.active_for_authentication?
        set_flash_message :notice, :updated_password, email: resource.email
        sign_in(resource_name, resource)
        respond_with resource, location: after_accept_path_for(resource)
      else
        set_flash_message :notice, :"updated_not_active", email: resource.email
        respond_with resource, location: new_session_path(resource_name)
      end
    end
  
    def accept_invitation_failure
      respond_with_navigational(resource) { render :edit }
    end
  end
  