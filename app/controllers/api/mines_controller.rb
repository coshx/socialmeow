class Api::MinesController < ApiController
  before_action :authenticate_user!, except: [:get_info_from_js]
  protect_from_forgery except: [:get_info_from_js]

  def create
  	params[:accounts].each do |account|
  		mine = Mine.find_by handle: account[:handle]
  		unless mine.present?
  			mine = current_user.mines.create(handle: account[:handle])
  		end
  	end
  	render json: {error: 0}
  end

  def get_info_from_js
  	user = User.find(params[:user_id])
  	mine = Mine.find_by handle: params[:account]
  	params[:accounts].each do |a|
  		a = a[1]
  		account = Account.find_by handle: a[:handle]
  		unless account.present?
  			account = user.accounts.new
  			account.smid = a[:id]
  			account.handle = a[:handle]
  			account.name = a[:name]
  			account.parent = params[:account]
  			account.description = a[:bio]
  			account.image_url = a[:image_url]
  			account.following = a[:following].present?
  			account.save!
  		end
  	end
  	mine.mined = true
  	mine.save!
  	render json: {error: 0}
  end

end