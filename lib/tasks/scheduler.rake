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

task :unfollow, [:user, :amount] => :environment do |t, args|
  user = User.find(args[:user])
  user.get_client
  args[:amount].to_i.times do |t|
  	user.safe_unfollow_one
  	sleep rand(1..3)
  end
end

task :who_back, [:user] => :environment do |t, args|
  user = User.find(args[:user])
  user.get_client
  user.check_who_followed_back
end

task :multi_follow => :environment do
  User.all.each do |user|
    user.get_client
    args[:amount].to_i.times do |t|
      user.follow_one
      sleep rand(1..3)
    end
  end
end

task :multi_unfollow => :environment do
  User.all.each do |user|
    user.get_client
    args[:amount].to_i.times do |t|
      user.safe_unfollow_one
      sleep rand(1..3)
    end
  end
end

task :multi_who_back => :environment do
  User.all.each do |user|
    user.get_client
    user.check_who_followed_back
  end
end
