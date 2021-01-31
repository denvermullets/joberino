class DailyScrapesController < ApplicationController
  def Linkedin
    url = [
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=100',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=125',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=100',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=125',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=150',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=175',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=200',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=100',
      # seattle below
      # https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area&start=100',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=full%20stack&location=Greater%20Seattle%20Area&start=125',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=100',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=125',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=150',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=175',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=software%20engineer&location=Greater%20Seattle%20Area&start=200',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=front%20end%20developer&location=Greater%20Seattle%20Area',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=front%20end%20developer&location=Greater%20Seattle%20Area&start=25',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=front%20end%20developer&location=Greater%20Seattle%20Area&start=50',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=front%20end%20developer&location=Greater%20Seattle%20Area&start=75',
      # 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000091&keywords=front%20end%20developer&location=Greater%20Seattle%20Area&start=100',
    ]

    response = ScrapeLinkedin.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = JobListing.all

      render :index, locals: { all_jobs: all_jobs }
    else
      render json: response
    end

  end
end
