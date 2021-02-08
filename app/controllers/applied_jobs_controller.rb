# Controller for Applied Jobs page
class AppliedJobsController < ApplicationController
  def index
    applied_jobs = UserJobListing.applied(current_user.id)

    render :index, locals: { applied_jobs: applied_jobs }
  end
end
