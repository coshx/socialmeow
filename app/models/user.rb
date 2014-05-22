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

  def follow_one
  	account = Account.where(followed:false).first
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

  def get_client
  	self.client = Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials.find_by(name:'api_key').code
      config.consumer_secret     = credentials.find_by(name:'api_secret').code
      config.access_token        = credentials.find_by(name:'access_token').code
      config.access_token_secret = credentials.find_by(name:'access_token_secret').code
    end
  end

end
