Rails.application.routes.draw do
  root to: 'job_listings#index'

  # resources :uploads
  get '/uploads', to: 'uploads#new_jobs', as: :upload
  post '/uploads', to: 'uploads#upload', as: :upload_json
  devise_for :users

  resources :daily_scrapes
  resources :user_job_listings
  resources :job_listings
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
