# creates an entry when a user takes action on a job id
class UserJobListingsController < ApplicationController
  def create
    UserJobListing.create(job_listing_id: params[:id], user_id: current_user.id, ignore: true)

    redirect_to request.referrer
  end
end
