Rails.application.routes.draw do
  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => :registrations }
  root to: 'visitors#index'
  get '/dashboard', to: 'users#dashboard'
  
  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
end
