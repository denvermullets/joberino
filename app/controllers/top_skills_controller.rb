# class that displays top skills from other scraping app, temporary manually added
class TopSkillsController < ApplicationController
  def index
    top_skills = %w[
      javascript java react c css html python aws sql angular api backend frontend git ux node spring
      typescript ruby docker go mysql android jquery php mongodb redux vue azure mvc github kubernetes postgresql
      json rails graphql webpack ai nosql r nodejs jira et sass bootstrap postgres redis express scala ajax
    ]

    render :index, locals: { top_skills: top_skills }
  end
end
