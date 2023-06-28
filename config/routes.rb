Rails.application.routes.draw do
  
  get 'user_show/show'
  resources :tasks do
    member do
      get 'approve'
      get 'reject'
    end
    resources :comments, only: [:index,:new, :create, :destroy, :edit, :update]
  end

  root to: "home#index" 

 resources :user_show, only: [:show]

  devise_for :users
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
end
