class JobListing < ApplicationRecord
  validates_uniqueness_of :job_title, scope: :employer, conditions: -> { where(scrape_time: Time.now > :scrape_time) }

  has_many :user_job_listings
  has_many :users, through: :user_job_listings

  scope :all_jobs, -> { JobListing.all.order(created_at: :desc) }
  scope :weekly, -> { where(created_at: Date.today.at_beginning_of_week..Time.now) }

  scope :applied, lambda { |user|
    joins(:user_job_listings).where(user_id: user)
  }
end
