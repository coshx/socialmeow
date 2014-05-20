class Api::CredentialsController < ApiController
  before_action :authenticate_user!

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
  		credential = current_user.credentials.find_by name: key
  		credential = current_user.credentials.new(name: key) unless credential.present?
  		credential.code = value
  		credential.save!
  	end
  	render json: {error: 0}
  end	
end
