class UserJobListing < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing

  scope :ignored_jobs, lambda { |user|
    where(user_id: user, ignore: true)
  }

  scope :ignored_weekly, lambda { |user|
    # where(user_id: user, ignore: true, created_at: 7.days.ago..Time.now)
    where(user_id: user, ignore: true, created_at: Date.today.at_beginning_of_week..Time.now)
  }

  scope :applied, lambda { |user|
    joins(:job_listing).where(user_id: user, applied: true)
  }
end
