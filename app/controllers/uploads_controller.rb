# class to upload json file to populate database
class UploadsController < ApplicationController
  before_action :authenticate_user!

  def upload
    uploaded_io = params[:json]
    jobs = JSON.parse(File.read(uploaded_io))
    jobs.map { |job| JobListing.create(job) }
  end
end
