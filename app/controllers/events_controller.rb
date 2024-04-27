class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    if current_user
      @events = current_user.events
    else
     
      redirect_to new_user_session_path
    end
    
  end

  # GET /events/1 or /events/1.json
  def show
    
      @event = Event.find(params[:id])
  
    
  end

  # GET /events/new
  def new
    @event = Event.new
    
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)
  
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def upcoming
    @upcoming_events = current_user.events.where('date >= ?', Date.today)
  end
  
  def past
    @past_events = current_user.events.where('date < ?', Date.today)
  end
  private
  def check_invitation_recipients
    @invitations.each do |invitation|
      unless invitation.recipient && invitation.recipient.email.present?
        flash.now[:alert] = "One or more invitations do not have a recipient assigned or the recipient's email address is missing."
        break
      end
    end
  end
      def set_event
        @event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: "Event not found."
      end
   
    

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :date, :time, :location)
    end
    def authorize_user!
      unless current_user == @event.user
        redirect_to root_path, alert: 'You are not authorized to access this event.'
      end
    end
end
