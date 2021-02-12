Rails.application.routes.draw do
  root to: 'job_listings#index'

  get '/changelog', to: 'changelogs#index', as: :changelog
  post '/uploads', to: 'uploads#upload', as: :upload_json
  get '/uploads', to: 'uploads#new_jobs', as: :upload
  get '/top-skills', to: 'top_skills#index', as: :top_skills

  devise_for :users

  resources :about
  resources :applied_jobs
  resources :daily_scrapes
  resources :user_job_listings
  resources :job_listings
  get '/all-jobs', to: 'job_listings#all_jobs', as: :all_joberinos
  resources :users
end
