class ProfilesController < ApplicationController
  def update
    if current_user.update(update_params)
      path = params[:user][:avatar] ? avatar_profile_path : edit_profile_path
      redirect_to path, notice: flash_msg(:on_update, current_user)
    else
      render :edit
    end
  end

  def update_avatar
    current_user.attributes = avatar_params
    current_user.crop_image!(:small)
    current_user.save(validate: false)
    redirect_to avatar_profile_path, notice: flash_msg(:on_update, current_user)
  end

  def update_password
    if current_user.update_with_password(password_params)
      bypass_sign_in(current_user)
      redirect_to password_profile_path(current_user),
                  notice: flash_msg(:on_update, current_user)
    else
      render action: :password
    end
  end

  private

  def update_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone, :avatar, :avatar_cache)
  end

  def avatar_params
    params.require(:user).permit(User::CROPPER_ATTRIBUTES)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
