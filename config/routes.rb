Rails.application.routes.draw do
  root to: 'job_listings#index'

  get '/changelog', to: 'changelogs#index', as: :changelog
  post '/uploads', to: 'uploads#upload', as: :upload_json
  get '/uploads', to: 'uploads#new_jobs', as: :upload

  devise_for :users

  resources :about
  resources :applied_jobs
  resources :daily_scrapes
  resources :user_job_listings
  resources :job_listings
  resources :users
end
