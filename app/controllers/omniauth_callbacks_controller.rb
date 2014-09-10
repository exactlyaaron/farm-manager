class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  protected

  def after_sign_up_path_for(resource)
    flash.notice = "Welcome to FarmManager, #{current_user.email}"
    dashboard_path
  end

  def after_sign_in_path_for(resource)
    flash.notice = "Welcome back, #{current_user.email}"
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_update_path_for(resource_or_scope)
    flash.notice = "Your account was updated successfully."
    '/dashboard'
  end
end