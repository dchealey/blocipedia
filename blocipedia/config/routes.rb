Rails.application.routes.draw do

  devise_for :users
    resources :articles
    resources :charges, only: [:new, :create]

    resources :articles do
      resources :collaborators, only: [:new, :create, :destroy]
    end

    root 'welcome#index'
end
