class OutfitElementsController < BaseController
  before_action :get_outfit_category
  before_action :get_outfit_element, except: [:new, :create]

  def new
    @outfit_element = @outfit_category.outfit_elements.new
  end

  def create
    @outfit_element = @outfit_category.outfit_elements.new(outfit_element_params)
    if @outfit_element.save
      redirect_to outfit_category_outfit_element_path(@outfit_category, @outfit_element),
                  notice: flash_msg(:on_create, @outfit_element)
    else
      render :new
    end
  end

  def update
    if @outfit_element.update(outfit_element_params)
      redirect_to outfit_category_outfit_element_path(@outfit_category, @outfit_element),
                  notice: flash_msg(:on_update, @outfit_element)
    else
      render :edit
    end
  end

  def destroy
    if @outfit_element.destroy
      redirect_to outfit_category_path(@outfit_category), notice: flash_msg(:on_destroy, @outfit_element)
    else
      redirect_to outfit_category_path(@outfit_category), alert: flash_msg(:on_not_destroy, @outfit_element)
    end
  end

  private

  def outfit_element_params
    params.require(:outfit_element).permit(:name, :symbol, :awf_code)
  end

  def get_outfit_category
    @outfit_category = OutfitCategory.find(params[:outfit_category_id])
  end

  def get_outfit_element
    @outfit_element = @outfit_category.outfit_elements.find(params[:id])
  end

  def duplicate_index
    message = if $ERROR_INFO.original_exception.error.include?('index_outfit_elements_on_outfit_category_id_and_symbol')
                t('errors.messages.duplicate_index.index_outfit_elements_on_outfit_category_id_and_symbol')
    end
    redirect_to :back, alert: message
  end
end
