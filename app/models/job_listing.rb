class JobListing < ApplicationRecord
  validates_uniqueness_of :job_title, scope: :employer, conditions: -> { where(created_at: 30.days.ago..Time.now) }

  has_many :user_job_listings
  has_many :users, through: :user_job_listings

  # no weekly_no_id scope is just for backwards compatability since i wasn't previously capturing geo_id's
  scope :all_jobs, -> { JobListing.all.order(created_at: :desc) }
  scope :weekly_nyc, -> { where(created_at: Date.today.at_beginning_of_week..Time.now, geo_id: '90000070') }
  scope :weekly_seattle, -> { where(created_at: Date.today.at_beginning_of_week..Time.now, geo_id: '90000091') }
  scope :weekly_no_id, -> { where(created_at: Date.today.at_beginning_of_week..Time.now, geo_id: nil) }
  scope :weekly, -> { weekly_nyc.or(weekly_no_id) }

  scope :applied, lambda { |user|
    joins(:user_job_listings).where(user_id: user)
  }
end
