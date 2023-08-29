# Rails.application.routes.draw do
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"

#   namespace :api do
#     get 'nonce', to: 'users#nonce'
#     post 'verify', to: 'users#verify'
#     delete 'logout', to: 'users#logout'
#   end


#   post 'users/create_or_fetch', to: 'users#create_or_fetch'
#   get '/api/check-auth-status', to: 'users#check_auth_status'


# end

Rails.application.routes.draw do
  namespace :api do
    get 'nonce', to: 'users#nonce'
    post 'verify', to: 'users#verify'
    delete 'logout', to: 'users#logout'
    get 'check-auth-status', to: 'users#check_auth_status'
  end

  post 'users/create_or_fetch', to: 'users#create_or_fetch'
end
