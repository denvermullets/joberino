# scrapes linkedin
class LinkedinNyc < Kimurai::Base
  @name = 'whatsnew'
  @engine = :selenium_chrome
  @@jobs = []

  def parse(response, url:, data: {})
    scrape_page

    File.open('tmp/today_jobs.json', 'w') do |f|
      f.write(JSON.pretty_generate(@@jobs))
    end

    response
  end

  # rubocop:disable Metrics/MethodLength
  def self.process
    @start_urls = [
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_WT=2&keywords=full%20stack',
      'https://www.linkedin.com/jobs/search/?f_WT=2&keywords=full%20stack&start=25',
      'https://www.linkedin.com/jobs/search/?f_WT=2&keywords=full%20stack&start=50',
      'https://www.linkedin.com/jobs/search/?f_WT=2&keywords=full%20stack&start=75',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=100',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20engineer',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20engineer&start=25',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20engineer&start=50',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20engineer&start=75',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20engineer&start=100',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20developer&location=New%20York%20City%20Metropolitan%20Area&start=100',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20developer',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20developer&start=25',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20developer&start=50',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20developer&start=75',
      'https://www.linkedin.com/jobs/search/?f_WT=2&software%20developer&start=100',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      'https://www.linkedin.com/jobs/search/?f_WT=2&front%20end%20developer',
      'https://www.linkedin.com/jobs/search/?f_WT=2&front%20end%20developer&start=25',
      'https://www.linkedin.com/jobs/search/?f_WT=2&front%20end%20developer&start=50',
      'https://www.linkedin.com/jobs/search/?f_WT=2&front%20end%20developer&start=75',

      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=junior%20end%20developer&location=New%20York%20City%20Metropolitan%20Area',
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=junior%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25'
    ]
    crawl!
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def scrape_page
    skip_list = %w[
      senior sr lead manager director vp president principal architect devops firmware forklift
      warehouse iii ii staff salesforce test ops c++ consulting contract head agent assistant representative
      operator mentor
    ]
    check_if_logged_in
    doc = browser.current_response
    puts 'cooling down'
    sleep 3.5
    puts 'warming up'

    while doc.css('li.jobs-search-results__list-item')[0]
      doc = browser.current_response
      job = strip_info(doc)

      options = {
        body: job.to_json,
        headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      }

      if skip_list.any? { |single_word| job[:job_title].downcase.include? single_word }
        puts "skipping #{job[:job_title]}"
      else
        post_req = HTTParty.post('https://joberino.dev/api/v1/job_listings', options)
        if post_req.success?
          job[:id] = post_req['id']
        else
          puts 'unable to create new record'
        end
        @@jobs << job
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
      salary: nil,
      geo_id: '90000070'
    }
  end

  def strip_url(url)
    # strips linkedin excess url noise
    old_url = url.split('/')

    "#{old_url[0]}//#{old_url[2]}/#{old_url[3]}/#{old_url[4]}/#{old_url[5]}"
  end

  def check_if_logged_in
    sleep 2
    begin
      # browser.find(:css, 'a.nav__button-secondary').click
      browser.find(:css, 'a.cta-modal__primary-btn').click
      sleep 1
      browser.fill_in 'session_key', with: ENV['EMAIL']
      browser.fill_in 'session_password', with: ENV['PASSWORD']
      sleep 2
      browser.find(:css, 'button.btn__primary--large').click
      sleep 1
    rescue Capybara::ElementNotFound
      puts 'user is logged in'
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
