Rails.application.routes.draw do
  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'visitors#index'
  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
end
