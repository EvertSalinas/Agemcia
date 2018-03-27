Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'pages#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root to: 'pages#dashboard'

  #get  '/quotation/download/:id', to: 'quotations#download_pdf'

  resources :quotations do
    member do
      get :download
    end
  end
  resources :products
end
