Raptor::Application.routes.draw do
  get "home/index"
  resources :photos

  match 'auth/:provider/callback', to: 'sessions#create'
  root :to => "home#index"
end
