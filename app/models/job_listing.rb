class JobListing < ApplicationRecord
  has_many :user_job_listings
  has_many :users, through: :user_job_listings

  scope :all_jobs, -> { JobListing.all }

  # scope :jobs, lambda { |user|
  #   joins(user_job_listings: :)
  # }
  # scope :approvers, lambda { |approver_id|
  #   joins(request_actors: :user).where(profiles: { id: approver_id }, request_actors: { role: 'approver' })
  # }
end
