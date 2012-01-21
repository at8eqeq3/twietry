Twietry::Application.routes.draw do

  match '/oembed' => 'oembed#endpoint'

  resources :hashtags

  resources :activities, :only => :index

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#fail'
  match '/auth/logout' => 'sessions#destroy'

  resources :users, :only => [:index, :show] do #TODO make it better!
    get 'page/:page', :action => :index, :on => :collection
    resources :activities, :only => :index
  end
  resources :verses do
    get 'page/:page', :action => :index, :on => :collection
    member do
      get 'simple'
      post 'love'
      post 'hate'
    end
    resources :lines, :only => [:create, :upvote, :downvote] do
      member do
        post 'create'
        post 'love'
        post 'hate'
      end
    end
  end

  match "/about" => "home#about"

  match "/support" => "home#support"
  match "/verses" => "verses#index"

  root :to => 'home#index'

end
