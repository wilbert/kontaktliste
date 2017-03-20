Rails.application.routes.draw do
  resources :contacts, only: [:index, :show, :update]
  root 'contacts#index'
  get '/healthcheck', to: -> _env { [200, { 'Content-Type' => 'text/plain' }, %w(ok)] }
end
