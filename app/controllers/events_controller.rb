class EventsController < BaseController
  before_action :get_event, except: [:index, :new, :create]
  def index
    @events = Event.ordered.page(params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(create_params)
    if @event.save
      redirect_to event_path(@event), notice: flash_msg(:on_create, @event)
    else
      render :new
    end
  end

  def update
    if @event.update(update_params)
      redirect_to event_path(@event), notice: flash_msg(:on_update, @event)
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path, notice: flash_msg(:on_destroy, @event)
    else
      redirect_to events_path, alert: flash_msg(:on_not_destroy, @event)
    end
  end

  private

  def create_params
    params.require(:event).permit(:name, :start_at, :end_at, :division)
  end

  def update_params
    params.require(:event).permit(:name)
  end

  def get_event
    @event = Event.find(params[:id])
  end
end
