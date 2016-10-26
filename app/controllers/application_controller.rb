class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :set_layout

  def flash_msg(type, record)
    t("notices.#{type}", model_name: record.model_name.human)
  end

  private

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end
end
