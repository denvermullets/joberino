# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    # need to make this more efficient, can see it take more time as it has to
    # go thru each loop
    all_jobs = JobListing.all
    ignored_jobs = UserJobListing.ignored_jobs(current_user.id)
    ignored_jobs_ids = ignored_jobs.map { |job| job.job_listing.id }
    filtered_jobs = all_jobs.select { |h| ignored_jobs_ids.exclude? h.id }

    render :index, locals: { all_jobs: filtered_jobs }
  end
end
