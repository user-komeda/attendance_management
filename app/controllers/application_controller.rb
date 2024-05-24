# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def after_sign_in_path_for(resource)
    if resource.has_role? :admin
      admin_root_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
