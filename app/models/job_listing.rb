class JobListing < ApplicationRecord
  has_many :user_job_listings
  has_many :users, through: :user_job_listings
end
