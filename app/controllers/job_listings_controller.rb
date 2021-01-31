# JobListings controller - displays all the current job listings
class JobListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    all_jobs = JobListing.all

    render :index, locals: { all_jobs: all_jobs }
  end
end
