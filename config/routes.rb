Rails.application.routes.draw do
  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => :registrations }
  root to: 'visitors#index'
  get '/dashboard', to: 'users#dashboard'

  resources :supplies, :only => [:index, :create, :new, :edit, :destroy]
  
  get 'supplies/:kind' => 'supplies#show_kind', as: :show_supply
  delete 'supplies/:kind/:id' => 'supplies#destroy', as: :destroy_supply

  get '/supplies/:kind/new', to: 'supplies#new', :defaults => { :kind => 'chemical' }, as: :new_chemical
  get '/supplies/:kind/new', to: 'supplies#new', :defaults => { :kind => 'fertilizer' }, as: :new_fertilizer
  get '/supplies/:kind/new', to: 'supplies#new', :defaults => { :kind => 'seed' }, as: :new_seed
  get '/supplies/:kind/new', to: 'supplies#new', :defaults => { :kind => 'general' }, as: :new_other

  resources :fields
end
