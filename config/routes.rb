Rails.application.routes.draw do
  root to: 'form#new'

  post '/form', to: 'form#create'
  get '/success', to: 'form#success'
end
