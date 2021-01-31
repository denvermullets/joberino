class User < ApplicationRecord
  has_many :user_job_listings
  has_many :job_listings, through: :user_job_listings
end
