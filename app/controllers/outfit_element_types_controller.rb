class OutfitElementTypesController < BaseController
  before_action :get_outfit_element_type, except: [:index, :new, :create]

  def index
    @outfit_element_types = OutfitElementType.ordered.page(params[:page])
  end

  def new
    @outfit_element_type = OutfitElementType.new
  end

  def create
    @outfit_element_type = OutfitElementType.new(outfit_element_type_params)
    if @outfit_element_type.save
      redirect_to outfit_element_types_path, notice: flash_msg(:on_create, @outfit_element_type)
    else
      render :new
    end
  end

  def update
    if @outfit_element_type.update(outfit_element_type_params)
      redirect_to outfit_element_types_path, notice: flash_msg(:on_update, @outfit_element_type)
    else
      render :edit
    end
  end

  def destroy
    if @outfit_element_type.destroy
      redirect_to outfit_element_types_path, notice: flash_msg(:on_destroy, @outfit_element_type)
    else
      redirect_to outfit_element_types_path, alert: flash_msg(:on_not_destroy, @outfit_element_type)
    end
  end

  private

  def outfit_element_type_params
    params.require(:outfit_element_type).permit(:name, :symbol, :position, :sex)
  end

  def get_outfit_element_type
    @outfit_element_type = OutfitElementType.find(params[:id])
  end

  def duplicate_index
    message = if $ERROR_INFO.original_exception.error.include?('index_outfit_element_types_on_symbol')
                t('errors.messages.duplicate_index.index_outfit_element_types_on_symbol')
              elsif $ERROR_INFO.original_exception.error.include?('index_outfit_element_types_on_sex_and_position')
                t('errors.messages.duplicate_index.index_outfit_element_types_on_sex_and_position')
    end
    redirect_to :back, alert: message
  end
end
