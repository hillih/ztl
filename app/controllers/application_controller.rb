class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :set_layout

  rescue_from ActiveRecord::DeleteRestrictionError, with: :restrict_dependent_destroy
  rescue_from ActiveRecord::RecordNotUnique, with: :duplicate_index

  def flash_msg(type, record)
    t("notices.#{type}", model_name: record.model_name.human)
  end

  protected

  def restrict_dependent_destroy
    redirect_to :back, alert: t('notices.delete_restriction_error')
  end

  def check_permissions
    case params[:action]
    when 'index'
      permission_denied unless current_user.can_section?(controller_name)
    when 'show'
      permission_denied unless current_user.can?("#{controller_name}:show")
    when 'new', 'create'
      permission_denied unless current_user.can?("#{controller_name}:new")
    when 'edit', 'update'
      permission_denied unless current_user.can?("#{controller_name}:edit")
    when 'destroy'
      permission_denied unless current_user.can?("#{controller_name}:destroy")
    else
      permission_denied
    end
  end

  def permission_denied
    redirect_to root_path, alert: t('notices.permission_denied')
  end

  private

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

  def duplicate_index
    redirect_to :back, alert: t('errors.message.duplicate_index.universal')
  end
end
