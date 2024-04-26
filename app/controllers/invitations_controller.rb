class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation, only: [:destroy, :update, :accept, :reject]
  
  def new
    @event = Event.find(params[:event_id])
    @invitation = @event.invitations.new
  end
  
  def create
    @event = Event.find(params[:event_id])
    @invitation = @event.invitations.new(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      flash[:notice] = 'Invitation sent successfully.'
      redirect_to event_path(@event) 
    else
      render :new
    end
  end

  def destroy
    authorize_user!
    @invitation.destroy
    redirect_to invitations_path, notice: 'Invitation deleted successfully.'
  end

  def update
    authorize_user!
    @invitation.update(invitation_params)
    redirect_to invitations_path, notice: 'Invitation updated successfully.'
  end

  def accept
    @invitation.accepted!
    redirect_to events_path, notice: 'Invitation accepted successfully.'
  end

  def reject
    @invitation.rejected!
    redirect_to notifications_path, notice: 'Invitation rejected successfully.'
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
    params.require(:invitation).permit(:recipient_id, :event_id, :status)
  end
end
