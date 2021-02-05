class DailyScrape < ApplicationRecord
  def scrape
    LinkedinJson.process

    BuiltInNyc.process
  end
end
