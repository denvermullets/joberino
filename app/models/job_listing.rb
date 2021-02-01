class JobListing < ApplicationRecord
  validates_uniqueness_of :job_title, scope: :employer

  has_many :user_job_listings
  has_many :users, through: :user_job_listings

  scope :all_jobs, -> { JobListing.all }
end
