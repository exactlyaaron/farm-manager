class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation]

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(registration_params)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(registration_params << :current_password, :budget)
    end
  end

  def after_sign_in_path_for(resource)
    flash.notice = "Welcome back, #{current_user.email}!"
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
