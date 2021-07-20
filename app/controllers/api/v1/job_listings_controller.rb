module Api
  module V1
    # api route to create job posts while scraping
    class JobListingsController < ApplicationController
      # To allow only json request
      protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }

      def create
        new_job = JobListing.create(job_listing_params)

        if new_job.persisted?
          render json: {}, status: 200
        else
          render json: {}, status: 400
        end
      end

      private

      def job_listing_params
        params.require(:job_listing).permit(
          :description, :job_title, :employer, :location, :company_url, :job_board, :geo_id, :job_url, :salary
        )
      end
    end
  end
end
