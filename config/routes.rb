Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'quotations#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root to: 'quotations#index'

  put 'quotations/complete',      to: 'quotations#complete'
  put 'quotations/reactivate',    to: 'quotations#reactivate'
  put 'quotations/cancel',        to: 'quotations#cancel'
  put 'quotations/pay',           to: 'quotations#pay'

  resources :quotations do
    member do
      get :download
    end
  end
  resources :products
end
