Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: 'messages#index'
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :goodings
    end
    #collection do
    #  get :search
    #end
  end

  resources :microposts, only: [:create, :destroy] do
    member do
      #get :goodings
      get :gooded
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  #resources :messages
  #resources :messages,except:[:index]

  #CRUD
  #get 'messages/:id', to: 'messages#show'
  #post 'messages', to: 'messages#create'
  #put 'messages/:id', to: 'messages#update'
  #delete 'messages/:id', to: 'messages#destroy'
  #index:showの補助ページ
  #get 'messages', to: 'messages#index'
  #new:新規作成用のフォームページ
  #get 'messages/new', to: 'messages#new'
  #edit:更新用のフォームページ
  #get 'messages/:id/edit', to: 'messages#edit'

  #get 'home/index', to: 'home#index'
  #root to: 'home#index'

end
