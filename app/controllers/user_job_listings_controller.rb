# creates an entry when a user takes action on a job id
class UserJobListingsController < ApplicationController
  def create
    case params[:interest]
    when 'ignore'
      UserJobListing.create(job_listing_id: params[:id], user_id: current_user.id, ignore: true)
    when 'applied'
      UserJobListing.create(job_listing_id: params[:id], user_id: current_user.id, applied: true, ignore: true)
    end

    redirect_to request.referrer
  end
end
