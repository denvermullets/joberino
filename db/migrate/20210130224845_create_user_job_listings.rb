class CreateUserJobListings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_job_listings do |t|
      t.belongs_to :job_listing
      t.belongs_to :user
      t.boolean :applied
      t.boolean :save_job

      t.timestamps
    end
  end
end
