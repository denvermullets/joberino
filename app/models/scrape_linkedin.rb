# scrapes linkedin
class ScrapeLinkedin < Kimurai::Base
  @name = 'linkedinerino'
  @engine = :selenium_chrome

  def self.process(url)
    @start_urls = url
    crawl!
  end

  def scrape_page
    check_if_logged_in
    doc = browser.current_response
    sleep 2

    while doc.css('li.jobs-search-results__list-item')[0]
      doc = browser.current_response
      JobListing.create(strip_info(doc))
      job_listings = doc.css('ul.jobs-search-results__list')
      job_listings.css('li.jobs-search-results__list-item')[0].remove
      browser.execute_script("document.querySelector('li.jobs-search-results__list-item').remove()")
      sleep 0.2
    end
  end

  def parse(response, url:, data: {})
    scrape_page

    response
  end

  def strip_info(doc)
    job_listings = doc.css('ul.jobs-search-results__list')
    single_job = job_listings.css('li.jobs-search-results__list-item')[0]

    {
      employer: single_job.css('a.job-card-container__company-name').text.strip.gsub(/\n/, ''),
      job_title: single_job.css('a.job-card-list__title').text.gsub(/\n/, '').strip.gsub(/\n/, ''),
      description: nil,
      location: single_job.css('li.job-card-container__metadata-item').text.strip.gsub(/\n/, ''),
      company_url: "https://linkedin.com#{single_job.css('a.job-card-container__company-name').attribute('href')}",
      job_board: 'linkedin',
      job_url: "https://linkedin.com#{single_job.css('a.job-card-list__title').attribute('href')}",
      salary: nil
    }
  end

  def check_if_logged_in
    sleep 2
    begin
      browser.find(:css, 'a.nav__button-secondary').click
      sleep 1
      browser.fill_in 'session_key', with: ENV['EMAIL']
      browser.fill_in 'session_password', with: ENV['PASSWORD']
      sleep 2
      browser.find(:css, 'button.btn__primary--large').click
    rescue Capybara::ElementNotFound
      puts 'user is logged in'
    end
  end
end
