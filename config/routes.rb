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
end
