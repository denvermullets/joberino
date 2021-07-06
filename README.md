## Joberino

This was previously an app that had 2 repo's and after wanting to make this a deployable version for friends to use, I just rewrote it as a singular Ruby on Rails app w/Bootstrap. It's not great, but it does what it needs to do.

![dk](https://i.imgur.com/UEMP6cB.png)

## What it do

Joberino pulls listings in the last 24hrs and adds them to a Postgresql database while avoiding duplicates based on company and job title. So no 2 'IBM - Software Engineer' roles. The idea is that it makes it easier to keep track of the 'new' job postings without having to see all the senior jobs and stuff you have viewed already. There's a small list of words that are in the avoid list [senior sr vp manager], etc. Feel free to add to this list.

The jobs list updates a couple of times a day, roughly at 9a / 12p / 5p. Currently you can only dismiss the job posting. Clicking on the job title opens a new tab for the job posting, clicking on the company brings up the company page.

Please feel free to make PR's since I think there are areas my code can be improved.

<!-- ### [LINK TO FRONTEND REPO](https://github.com/denvermullets/joberino-portal-frontend) -->

## Installation

This is built using `Ruby 2.7.2` and `Rails 6.1.1`. Please make sure you're using at least those versions of Ruby / Rails. Bundle install should take care of you for the rest though.

## Errors

If chromium becomes out of date you just need to run `brew upgrade --cask` - or at least I do!
