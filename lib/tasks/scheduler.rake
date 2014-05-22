require 'pry'

desc "This task is called by the Heroku scheduler add-on"
task :follow, [:user, :amount] => :environment do |t, args|
  user = User.find(args[:user])
  user.get_client
  args[:amount].to_i.times do |t|
  	user.follow_one
  	sleep rand(1..3)
  end
end

task :send_reminders => :environment do
  puts "yo"
end