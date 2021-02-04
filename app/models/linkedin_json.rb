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

  # def self.process(url)
  def self.process
    # @start_urls = url
    @start_urls = [
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=75',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=100',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=100',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=junior%20end%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=junior%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25'
    ]
    crawl!
  end

  def scrape_page
    skip_list = %w[senior sr lead manager director vp president principal architect devops firmware]
    check_if_logged_in
    doc = browser.current_response
    puts 'cooling down'
    sleep 3.5
    puts 'warming up'

    while doc.css('li.jobs-search-results__list-item')[0]
      doc = browser.current_response
      job = strip_info(doc)
      if skip_list.any? { |single_word| job[:job_title].downcase.include? single_word }
        puts "skipping #{job[:job_title]}"
      else
        @@jobs << strip_info(doc)
        puts "adding #{job[:job_title]}"
      end
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
      job_url: strip_url("https://linkedin.com#{single_job.css('a.job-card-list__title').attribute('href')}"),
      salary: nil
    }
  end

  def strip_url(url)
    old_url = url.split('/')

    "#{old_url[0]}//#{old_url[2]}/#{old_url[3]}/#{old_url[4]}/#{old_url[5]}"
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
