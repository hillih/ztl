class OutfitCategoriesController < BaseController
  before_action :get_outfit_category, except: [:index, :new, :create]

  def index
    @outfit_categories = OutfitCategory.first_level.page(params[:page])
  end

  def show
    @subcategories = @outfit_category.children.page(params[:page]) unless @outfit_category.last_category
    @outfit_elements = @outfit_category.last_category ? @outfit_category.outfit_elements.page(params[:page]) : nil
  end

  def new
    @outfit_category = OutfitCategory.new
  end

  def create
    @outfit_category = OutfitCategory.new(outfit_category_params)
    if @outfit_category.save
      redirect_to outfit_category_path(@outfit_category), notice: flash_msg(:on_create, @outfit_category)
    else
      render :new
    end
  end

  def update
    if @outfit_category.update(outfit_category_params)
      redirect_to outfit_category_path(@outfit_category), notice: flash_msg(:on_update, @outfit_category)
    else
      render :edit
    end
  end

  def destroy
    if @outfit_category.destroy
      redirect_to outfit_categories_path, notice: flash_msg(:on_destroy, @outfit_category)
    else
      redirect_to outfit_categories_path, alert: flash_msg(:on_not_destroy, @outfit_category)
    end
  end

  private

  def outfit_category_params
    params.require(:outfit_category).permit(:name, :symbol, :parent_id, :last_category, :re_hire, :outfit_element_type_id)
  end

  def get_outfit_category
    @outfit_category = OutfitCategory.find(params[:id])
  end

  def duplicate_index
    message = if $ERROR_INFO.original_exception.error.include?('index_outfit_categories_on_parent_id_and_symbol')
                t('errors.messages.duplicate_index.index_outfit_categories_on_parent_id_and_symbol')
              elsif $ERROR_INFO.original_exception.error.include?('index_outfit_categories_on_symbol')
                t('errors.messages.duplicate_index.index_outfit_categories_on_symbol')
    end
    redirect_to :back, alert: message
  end
end
