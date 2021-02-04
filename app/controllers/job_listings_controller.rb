# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    # need to make this more efficient as i can see it takes more time as it has to
    # go thru each individual loop

    ignored_jobs = UserJobListing.ignored_weekly(current_user.id).map { |job| job.job_listing.id }
    filtered_jobs = JobListing.weekly.select { |h| ignored_jobs.exclude? h.id }

    render :index, locals: { all_jobs: filtered_jobs, job_count: JobListing.weekly.count }
  end
end
