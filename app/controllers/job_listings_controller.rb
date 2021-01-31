# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  def index
    all_jobs = JobListing.all

    render :index, locals: { all_jobs: all_jobs }
  end
end
