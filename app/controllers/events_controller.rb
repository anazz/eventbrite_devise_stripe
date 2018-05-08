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

  def subscribe
    @event = Event.find(params[:id])
    if 
      @event.user_attendees.include? current_user
      flash[:error] = "Vous participez déjà à l'événement !" 
      redirect_to @event
      return  
    end

    # Amount in cents
    @amount = @event.price

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @event.user_attendees << current_user
    flash[:success] = "Vous participez à l'événement !" 
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event

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
