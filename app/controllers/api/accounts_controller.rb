class Api::AccountsController < ApiController
  before_action :authenticate_user!

  def index
    accounts = current_user.accounts.where(parent: nil)
  	render json: accounts.to_json(methods: [:to_mine, :was_mined])
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
    set_twitter_client
    followers = @client.followers
    followers.each do |f|
      account = Account.new(user_id: current_user.id, handle: f.handle, smid: f.id, name: f.name, image_url: f.profile_image_url.to_s, followed: true)
      account.following = true
      account.save!
    end
  end
end
