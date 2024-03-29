Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  post '/auth/login', to: 'authentication#login'
  get '/auth/verify', to: 'authentication#verify'

  get "/games", to: "games#get_games"
  post "/games", to: "games#add_games"
  post "/add-player-to-game", to: "games#add_player_to_game"
  post "/remove-player-from-game", to: "games#remove_player_from_game"

  post "/invites", to: "invites#invite_players"

  get "/users", to: "users#index"
  post "/users", to: "users#create"
  post "/user-verify", to: "users#verify"

  root to: "static#home"
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
