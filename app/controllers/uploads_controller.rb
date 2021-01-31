# class to upload json file to populate database
class UploadsController < ApplicationController
  # def new_jobs
  # end

  def upload
    uploaded_io = params[:json]
    jobs = JSON.parse(File.read(uploaded_io))
    jobs.map { |job| JobListing.create(job) }
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
    # binding.pry
  end
end
