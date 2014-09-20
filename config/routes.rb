Rails.application.routes.draw do
  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => :registrations }
  root to: 'visitors#index'
  get '/dashboard', to: 'users#dashboard'

  resources :supplies, :only => [:index, :create, :new, :edit, :destroy, :update]
  
  get '/supplies/new/:kind', to: 'supplies#new', as: :new_specific_supply
  get 'supplies/:kind' => 'supplies#show_kind', as: :show_supply
  delete 'supplies/:kind/:id' => 'supplies#destroy', as: :destroy_supply

  resources :fields

  get '/fields/:id/treatments/new', to: 'treatments#new', as: :new_treatment
  post '/fields/:id/treatments/new', to: 'treatments#create', as: :create_treatment
  get '/fields/:id/treatments/:treatment_id', to: 'treatments#show', as: :show_treatment
  get '/fields/:id/treatments/:treatment_id/edit', to: 'treatments#edit', as: :edit_treatment
  patch '/fields/:id/treatments/:treatment_id/edit', to: 'treatments#update', as: :update_treatment
  delete '/fields/:id/treatments/:treatment_id', to: 'treatments#destroy', as: :destroy_treatment

  get '/fields/:id/harvest_loads/new', to: 'harvest_loads#new', as: :new_harvest_load
  post '/fields/:id/harvest_loads/new', to: 'harvest_loads#create', as: :create_harvest_load
  get '/fields/:id/harvest_loads/:harvest_load_id/edit', to: 'harvest_loads#edit', as: :edit_harvest_load
  patch '/fields/:id/harvest_loads/:harvest_load_id/edit', to: 'harvest_loads#update', as: :update_harvest_load
  delete '/fields/:id/harvest_loads/:harvest_load_id', to: 'harvest_loads#destroy', as: :destroy_harvest_load
end
