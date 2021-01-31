class UserJobListing < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing

  scope :ignored_jobs, lambda { |user|
    where(user_id: user, ignore: true)
  }
  # scope :approvers, lambda { |approver_id|
  #   joins(request_actors: :user).where(profiles: { id: approver_id }, request_actors: { role: 'approver' })
  # }
end
