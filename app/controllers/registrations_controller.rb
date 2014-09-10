class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    flash.notice = "Welcome to FarmManager, #{current_user.email}"
    dashboard_path
  end

  def after_update_path_for(resource)
    flash.notice = "Your account was updated successfully."
    dashboard_path
  end
end