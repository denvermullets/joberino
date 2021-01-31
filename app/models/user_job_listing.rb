class UserJobListing < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing

  scope :ignored_jobs, lambda { |user|
    where(user_id: user, ignore: true)
end
