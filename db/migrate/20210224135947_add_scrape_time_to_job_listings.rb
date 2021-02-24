class AddScrapeTimeToJobListings < ActiveRecord::Migration[6.1]
  def change
    add_column :job_listings, :scrape_time, :datetime
  end
end
