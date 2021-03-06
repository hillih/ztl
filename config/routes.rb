Rails.application.routes.draw do
  devise_for :users
  root 'application#index'

  resources :users
  resource :profile, only: [:edit, :update] do
    %i(password avatar).each do |resource|
      get resource, on: :member
      patch :"update_#{resource}", on: :member
    end
  end
  resources :roles
  resources :outfit_element_types, except: :show
  resources :outfit_categories do
    resources :outfit_elements, except: :index
  end
  resources :events do
    resources :choreographies, except: :index do
      get :edit_settings, on: :member
      patch :update_settings, on: :member
    end
  end
end
