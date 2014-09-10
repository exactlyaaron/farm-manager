class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    flash.notice = "Welcome to Farm Manager"
    render 'dashboard'
  end

end