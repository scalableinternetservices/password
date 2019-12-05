Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'application#feed'
  get '/user/:id', to: 'application#user'
  post '/comments/create', to: 'comment#create'
  get '/profile', to: 'application#profile'
  post '/profile_picture', to: 'application#picture'
  get '/commentfeed', to: 'comment#feed'
  post '/connection/new', to: 'application#new_connection'
  get '/network', to: 'application#network'
  get '/drop', to: 'application#drop'
  devise_for :users, components: {registrations: 'registrations'}
end
