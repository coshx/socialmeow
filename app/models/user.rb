class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :credentials
  has_many :accounts
  has_many :mines
  has_many :batches
  
  cattr_accessor :client

  def followed_back
  	accounts.where(followed_back: true).where.not(following: true)
  end

  def followed
    accounts.where(followed: true, following: false).order(:followed_date)
  end

  def follow_one
  	account = accounts.where(followed:false, following:false).first
  	error = ""
  	begin
  		client.follow(account.handle)
  	rescue Exception => e
  		error = e.message
  		puts "was some kinda error with #{account.handle}: #{e.message}"
  		account.error = error
  	end
  	unless error == "Rate limit exceeded"
	  	account.followed = true
	  	account.followed_date = DateTime.now
	  	account.save!
	  	puts "Account #{account.handle} was followed and saved!"
	end
  end
  
  def unfollow_one
  	account = accounts.where(followed:true, unfollowed:false, followed_back: false).order(:followed_date).first
  	begin
  		client.unfollow(account.handle)
  	rescue Exception => e
  		error = e.message
  		puts "was some kinda error with #{account.handle}: #{e.message}"
  		account.error = error
  	end
  	unless error == "Rate limit exceeded"
	  	account.unfollowed = true
	  	account.unfollowed_date = DateTime.now
	  	account.save!
	  	puts "Account #{account.handle} was followed and saved!"
	end
  end

  def safe_unfollow_one
  	# unfollow only 
  	# who didn't follow back
  	# And who you followed more than 1 day ago
  	account = accounts.where(followed:true, unfollowed:false, followed_back: false).order(:followed_date).first
  	return unless account.followed_date.present?
  	return unless (Time.now - account.followed_date).to_i / 1.day >= 1
  	begin
  		client.unfollow(account.handle)
  	rescue Exception => e
  		error = e.message
  		puts "was some kinda error with #{account.handle}: #{e.message}"
  		account.error = error
  	end
  	unless error == "Rate limit exceeded"
	  	account.unfollowed = true
	  	account.unfollowed_date = DateTime.now
	  	account.save!
	  	puts "Account #{account.handle} was UNfollowed and saved!"
	end
  end

  def get_client
  	self.client = Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials.find_by(name:'api_key').code
      config.consumer_secret     = credentials.find_by(name:'api_secret').code
      config.access_token        = credentials.find_by(name:'access_token').code
      config.access_token_secret = credentials.find_by(name:'access_token_secret').code
    end
  end

  def check_who_followed_back
  	follower_ids = client.follower_ids.to_a
  	user_accounts = accounts.where.not(following: true).where(followed:true)
  	user_accounts.each do |a|
  		if follower_ids.include? a.smid.to_i
  			a.followed_back = true
  			a.save!
  		end
  	end
  end

end
