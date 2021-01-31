# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    all_jobs = JobListing.all
    ignored_jobs = UserJobListing.ignored_jobs(current_user.id)
    ignored_jobs_ids = ignored_jobs.map { |job| job.job_listing.id }
    filtered_jobs = all_jobs.select { |h| ignored_jobs_ids.exclude? h.id }

    render :index, locals: { all_jobs: filtered_jobs }
  end
end
