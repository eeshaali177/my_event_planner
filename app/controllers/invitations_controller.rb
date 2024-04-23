class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation, only: [:destroy, :update]
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_user.invitations.build(invitation_params)
    if @invitation.save
      redirect_to @invitation.event, notice: 'Invitation sent successfully.'
    else
      render :new
    end
  end

  def destroy
    @invitation.destroy
    redirect_to invitations_path, notice: 'Invitation deleted successfully.'
  end

  def update
    @invitation.update(status: 'accepted')
    redirect_to invitations_path, notice: 'Invitation accepted successfully.'
  end

  private

  def set_invitation
    @invitation = current_user.received_invitations.find(params[:id])
  end

  def authorize_user!
    unless current_user.id == @invitation.sender_id
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def invitation_params
    params.require(:invitation).permit(:recipient_id, :event_id)
  end
end
