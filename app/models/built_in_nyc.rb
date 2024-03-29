# scrapes jobs from BuiltInNyc
class BuiltInNyc < Kimurai::Base
  @name = 'Builtinnyc'
  @engine = :selenium_chrome
  @@jobs = []

  def parse(response, url:, data: {})
    scrape_page

    File.open('tmp/today_jobs.json', 'w') do |f|
      f.write(JSON.pretty_generate(@@jobs))
    end

    response
  end

  def self.process
    @start_urls = [
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=1',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=2',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=3',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=4',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=5',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=6',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=7',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=8',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=9',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=10',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=11',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=12',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=13',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=14',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=15'
    ]
    crawl!
  end

  # rubocop:disable Metrics/AbcSize
  def scrape_page
    skip_list = %w[
      senior sr lead manager director vp president principal architect devops firmware forklift
      warehouse iii ii staff salesforce test ops c++ consulting contract head
    ]

    sleep 7 # let vue page load
    doc = browser.current_response

    # we're removing the div that contains the job filtering stuff since it's preventing the page to move
    # when we delete the job compoenent that triggers the next jobs which are vue lazy-load components
    browser.execute_script("document.querySelector('div.block-jobs-facets').remove()")

    while doc.css('div.job-item')[0]
      # browser.save_screenshot
      doc = browser.current_response
      job = strip_info(doc)

      options = {
        body: job.to_json,
        headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      }

      if skip_list.any? { |single_word| job[:job_title].downcase.include? single_word }
        puts "skipping #{job[:job_title]}"
      else
        @@jobs << job
        puts "adding #{job[:job_title]}"
        post_req = HTTParty.post('https://joberino.dev/api/v1/job_listings', options)
        puts "This POST request was #{post_req.success?}"
      end

      doc.css('div.job-item')[0].remove
      browser.execute_script("document.querySelector('div.job-item').remove()")
      sleep 0.1
    end
  end

  def strip_info(doc)
    single_job = doc.css('div.job-item')[0]
    {
      employer: single_job.css('div.company-title span')[0].text.strip.gsub(/\n/, ''),
      job_title: single_job.css('h2.job-title')[0].text.strip.gsub(/\n/, ''),
      description: single_job.css('div.job-description').text.strip.gsub(/\n/, ''),
      location: 'Greater NYC area',
      company_url: nil,
      job_board: 'builtinnyc',
      job_url: single_job.css('a.job-row').attribute('href').value,
      salary: nil,
      geo_id: '90000070'
    }
  end
  # rubocop:enable Metrics/AbcSize
end
