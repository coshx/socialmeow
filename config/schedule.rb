# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "./cron_log.log"
#
every 2.minutes do
  rake "follow[1,1]",  environment: "development"
  rake "unfollow[1,1]",  environment: "development"
end

every 12.hours do
  rake "who_back[1]",  environment: "development"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
