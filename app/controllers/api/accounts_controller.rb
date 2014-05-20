class Api::AccountsController < ApiController
  before_action :authenticate_user!

  def index
    accounts = current_user.accounts
  	render json: accounts.to_json
  end

  def update
  end

  def create
  	params[:credentials].each do |key, value|
  		credential = current_user.credentials.find_by name: key
  		credential = current_user.credentials.new(name: key) unless credential.present?
  		credential.code = value
  		credential.save!
  	end
  	render json: {error: 0}
  end	

  def get_initial_followers
    client = twitter_client
    followers = client.followers
    followers.each do |f|
      account = Account.new(handle: f.handle, smid: f.id, name: f.name, image_url: f.profile_image_url.to_s)
      account.save!
    end
  end
end
