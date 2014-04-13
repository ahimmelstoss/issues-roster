Rails.application.routes.draw do
  root 'sessions#new'
  get '/auth/github' => 'auth#github'
  get '/auth/github/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/organizations' => 'organizations#index', :as => 'organizations'
  get '/organizations/:organization' => 'organizations#show', :as => 'organization'
  get '/organizations/:organization/repos' => 'repos#index', :as => 'repos'
  get '/organizations/:organization/repos/:repo' => 'repos#show', :as => 'repo'
end
