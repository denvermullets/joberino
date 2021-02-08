# class to upload json file to populate database
class UploadsController < ApplicationController
  before_action :authenticate_user!

  def new_jobs
    render :new_jobs, locals: { job_count: JobListing.count, week_count: JobListing.weekly.count, all_users: User.all, job_actions: UserJobListing.count }
  end

  def upload
    uploaded_io = params[:json]
    jobs = JSON.parse(File.read(uploaded_io))
    jobs.map { |job| JobListing.create(job) }

    render :new_jobs, locals: { job_count: JobListing.count, week_count: JobListing.weekly.count, all_users: User.all, job_actions: UserJobListing.count }
  end
end
