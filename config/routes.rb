Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'application#feed'
  get '/user/:id', to: 'application#user'
  post '/comments/create', to: 'comment#create'
  get '/test', to: 'application#test'
  get '/test2', to: 'application#test2'
  devise_for :users, components: {registrations: 'registrations'}
end
