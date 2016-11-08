class ChoreographiesController < BaseController
  before_action :get_event
  before_action :get_choreography, except: [:new, :create]

  def new
    redirect_to event_path(@event), alert: t('notices.cannot_create_choreography') unless @event.division
    @choreography = @event.choreographies.new
  end

  def create
    @choreography = @event.choreographies.new(choreography_params)
    if @choreography.save
      redirect_to event_choreography_path(@event, @choreography), notice: flash_msg(:on_create, @choreography)
    else
      render :new
    end
  end

  def update
    if @choreography.update(choreography_params)
      redirect_to event_choreography_path(@event, @choreography), notice: flash_msg(:on_update, @choreography)
    else
      render :edit
    end
  end

  def update_settings
    if @choreography.update(settings_params)
      redirect_to event_choreography_path(@event, @choreography), notice: flash_msg(:on_update, @choreography)
    else
      render :edit_settings
    end
  end

  def destroy
    if @choreography.destroy
      redirect_to event_path(@event), notice: flash_msg(:on_destroy, @choreography)
    else
      redirect_to event_path(@event), alert: flash_msg(:on_not_destroy, @choreography)
    end
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end

  def get_choreography
    @choreography = @event.choreographies.find(params[:id])
  end

  def choreography_params
    params.require(:choreography).permit(:outfit_category_id, :name)
  end

  def settings_params
    params.require(:choreography).permit(choreography_settings_attributes: [:id, :outfit_category_id])
  end

  def check_permissions
    case params[:action]
    when 'edit_settings', 'update_settings'
      permission_denied unless current_user.can?('choreographies:edit_settings')
    else
      super
    end
  end

  def duplicate_index
    message = if $ERROR_INFO.original_exception.error.include?('index_choreographies_on_event_id_and_outfit_category_id')
                t('errors.messages.duplicate_index.index_choreographies_on_event_id_and_outfit_category_id')
    end
    redirect_to :back, alert: message
end
end
