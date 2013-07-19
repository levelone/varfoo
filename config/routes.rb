Varfoo::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')

  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  # get 'sign_up' => 'users#new', :as => 'sign_up'
  get 'tags/:tag', to: 'articles#index', as: :tag

  resources :users
  resources :sessions

  resources :articles do
    resources :comments, :controller => 'articles/comments'
  end

  root :to => 'articles#index'
end

