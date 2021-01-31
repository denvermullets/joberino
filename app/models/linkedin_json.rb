# scrapes linkedin
class LinkedinJson < Kimurai::Base
  @name = 'linkedinerino'
  @engine = :selenium_chrome
  @@jobs = []

  def parse(response, url:, data: {})
    scrape_page

    File.open('tmp/today_jobs.json', 'w') do |f|
      f.write(JSON.pretty_generate(@@jobs))
    end

    response
  end

  def self.process(url)
    @start_urls = url
    crawl!
  end

  def scrape_page
    skip_list = %w[senior sr lead manager director vp president principal architect]
    check_if_logged_in
    doc = browser.current_response
    sleep 2

    while doc.css('li.jobs-search-results__list-item')[0]
      doc = browser.current_response
      job = strip_info(doc)
      # binding.pry
      if skip_list.any? { |single_word| job[:job_title].downcase().include? single_word }
        puts "skipping #{job[:job_title]}"
      else
        @@jobs << strip_info(doc)
        puts "adding #{job[:job_title]}"
      end
      # @@jobs << strip_info(doc)
      # puts 'loaded job a job'
      job_listings = doc.css('ul.jobs-search-results__list')
      job_listings.css('li.jobs-search-results__list-item')[0].remove
      browser.execute_script("document.querySelector('li.jobs-search-results__list-item').remove()")
      sleep 0.2
    end
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
