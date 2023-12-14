Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  root to: "homes#top"
  devise_for :users

  get "/home" => "homes#top", as: "/"
  get "/home/about" => "homes#about", as: "about"

  resources :books

  resources :users, only: [:show, :edit, :update, :index] # 追加


devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy', as: :user_session_new
  delete '/users/sign_out' => 'devise/sessions#destroy', as: :user_session_destroy
  end
end