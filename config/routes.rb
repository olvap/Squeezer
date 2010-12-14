Rails.application.routes.draw do |map|

  resources :blogs
  
  resources :comments do
    member do
      get :crear
      get :open
      get :close
      get :remove
    end 
  end

  resources :users do
    member do
      get :roles
    end 
  end

  resources :roles

  resources :posts
  
  resources :pages

end