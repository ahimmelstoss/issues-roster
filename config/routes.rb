Rails.application.routes.draw do
  root 'sessions#new'
  get '/auth/github' => 'auth#github', as: 'github_login'
  get '/auth/github/callback' => 'sessions#create', as: 'github_callback'
  get '/repos/index' => 'repos#index', as: 'repos_index'
end
