Rails.application.routes.draw do
  root 'sessions#new'
  get '/auth/github' => 'auth#github'
  get '/auth/github/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/organizations/index' => 'organizations#index'
end
