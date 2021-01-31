class CreateDailyScrapes < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_scrapes do |t|

      t.timestamps
    end
  end
end
