Rails.application.routes.draw do
  resources :daily_scrapes
  resources :user_job_listings
  resources :job_listings
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
