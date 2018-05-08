class EventsController < ApplicationController
  
  def index
    @events = Event.all
    # @creator_id = current_user.id
  end

  def index_all
    @events = Event.all
  end  

  def edit
    @event = Event.find(params[:id])
  end  

  def update
    @event = Event.find(params[:id])
    
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end  

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    if @event.save
        redirect_to @event
    else
        render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def subscribe

  end  

  private
  def event_params
    params.require(:event).permit(:description, :date, :place, :creator_id)
  end
end
