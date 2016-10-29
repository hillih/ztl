class RolesController < BaseController
  before_action :get_role, except: [:index, :new, :create]
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def index
    @roles = Role.all.page(params[:page])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to role_path(@role), notice: flash_msg(:on_create, @role)
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      redirect_to role_path(@role), notice: flash_msg(:on_update, @role)
    else
      render :edit
    end
  end

  def destroy
    if @role.destroy
      redirect_to roles_path, notice: flash_msg(:on_destroy, @role)
    else
      redirect_to roles_path, alert: flash_msg(:on_not_destroy, @role)
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :symbol, permissions: [])
  end

  def get_role
    @role = Role.find(params[:id])
  end

  def record_not_unique
    redirect_to :back, alert: t('roles.symbol_is_not_unique')
  end
end
