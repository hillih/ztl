class BaseController < ApplicationController
  before_action :check_permissions
end
