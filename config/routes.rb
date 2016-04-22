Rails.application.routes.draw do

  resources :topics do
     resources :posts, except: [:index]
   end

  resources :users, only: [:new, :create]
  
  resources :posts

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
