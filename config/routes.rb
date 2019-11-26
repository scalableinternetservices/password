Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'application#feed'
  get '/user/:id', to: 'application#user'
  post '/comments/create', to: 'comment#create'
  devise_for :users, components: {registrations: 'registrations'}
  get '/comment/feed', to: 'comment#feed'
end
