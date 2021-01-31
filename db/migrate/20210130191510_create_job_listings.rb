class CreateJobListings < ActiveRecord::Migration[6.1]
  def change
    create_table :job_listings do |t|
      t.string :employer
      t.string :job_title
      t.text :description
      t.string :location
      t.string :company_url
      t.string :job_board
      t.integer :geo_id
      t.string :job_url
      t.string :salary

      t.timestamps
    end
  end
end
