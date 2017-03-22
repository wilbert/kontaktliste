Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :update]
    end
  end

  root 'api/v1/contacts#index'

  get '/healthcheck', to: ->(_env) { [200, { 'Content-Type' => 'text/plain' }, %w(ok)] }
end
