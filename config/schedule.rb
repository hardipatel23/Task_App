
# Learn more: http://github.com/javan/whenever

# update whenever --update-crontab
# whenever --update-crontab --set environment='development'
# bundle exec rake task_autocreation:create_tasks
# Clear your crontab: whenever --clear-crontab
# See your cron jobs: crontab -l

# require File.expand_path(File.dirname(__FILE__) + "/environment")

# set :environment, "development"


set :output, "./log/log.log"

# every 1.minutes do
#   rake "task_autocreation:create_tasks"
# end

every 1.day, at: '11:00 am' do
  rake "task_autocreation:create_tasks"
end

