class UsersController < BaseController
  before_action :get_user, except: [:index, :new, :create]

  def index
    @users = User.ordered.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      redirect_to user_path(@user), notice: flash_msg(:on_create, @user)
    else
      render :new
    end
  end

  def update
    if @user.update(update_params)
      redirect_to user_path(@user), notice: flash_msg(:on_update, @user)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: flash_msg(:on_destroy, @user)
    else
      redirect_to users_path, alert: flash_msg(:on_not_destroy, @user)
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name, :phone, :sex, :role_id)
  end

  def update_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone, :sex, :role_id)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
