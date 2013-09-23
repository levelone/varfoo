require 'sidekiq/web'

Varfoo::Application.routes.draw do
  # post 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'sign_up' => 'admins#new', :as => 'sign_up'
  get 'tags/:tag', to: 'articles#index', as: :tag
  get 'new' => 'articles#new', as: 'new'

  resources :admins
  resources :sessions

  resources :articles do
    resources :comments, :controller => 'articles/comments'
    resources :likes, :controller => 'articles/likes', only: [:create]
  end

  root :to => 'articles#index'

  mount Sidekiq::Web, at: '/sidekiq'
end

