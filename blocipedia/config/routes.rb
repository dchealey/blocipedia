Rails.application.routes.draw do

  devise_for :users
    resources :articles
    resources :charges, only: [:new, :create]

    root 'welcome#index'
end
