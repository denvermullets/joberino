# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    # need to make this more efficient as i can see it takes more time each job is loaded
    # as it has to go thru each individual loop, currently manageable on a weekly basis since
    # JS takes care of removing a job that has an action taken on it. viewing all jobs will only get slower.

    ignored_jobs = UserJobListing.ignored_weekly(current_user.id).map { |job| job.job_listing.id }
    filtered_jobs = JobListing.weekly.select { |h| ignored_jobs.exclude? h.id }

    render :index, locals: { all_jobs: filtered_jobs, job_count: JobListing.weekly.count }
  end

  def all_jobs
    ignored_jobs = UserJobListing.ignored_jobs(current_user.id).map { |job| job.job_listing.id }
    filtered_jobs = JobListing.all_jobs.select { |h| ignored_jobs.exclude? h.id }

    render :all_jobs, locals: { all_jobs: filtered_jobs, job_count: JobListing.count }
  end

  def seattle_jobs
    ignored_jobs = UserJobListing.ignored_weekly(current_user.id).map { |job| job.job_listing.id }
    filtered_jobs = JobListing.weekly_seattle.select { |h| ignored_jobs.exclude? h.id }

    render :seattle, locals: { all_jobs: filtered_jobs, job_count: JobListing.weekly.count }
  end
end
