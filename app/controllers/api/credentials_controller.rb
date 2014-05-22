class Api::CredentialsController < ApiController
  before_action :authenticate_user!
  VALID_CREDENTIALS = %w(api_key api_secret access_token access_token_secret)
  def index
  	credentials = {}
  	current_user.credentials.each do |c|
  		credentials[c.name] = c.code
  	end
  	render json: [credentials].to_json
  end

  def update
  end

  def create
  	params[:credentials].each do |key, value|
  		if VALID_CREDENTIALS.include? key
	  		credential = current_user.credentials.find_by name: key
	  		credential = current_user.credentials.new(name: key) unless credential.present?
	  		credential.code = value
	  		credential.save!
	  	end
  	end
  	render json: {error: 0}
  end	
end
