class Api::MinesController < ApiController
  before_action :authenticate_user!, except: [:get_info_from_js]
  protect_from_forgery except: [:get_info_from_js]

  def create
  	binding.pry
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
  	params[:accounts].each do |account|
  		account = account[1]
  		account = Account.find_by handle: account[:handle]
  		unless account.present?
  			account = user.accounts.new
  			account.smid = account[:id]
  			account.handle = account[:handle]
  			account.parent = params[:account]
  			account.image_url = account[:image_url]
  			account.following = account[:following].present?
  			account.save!
  		end
  	end
  	mine.mined = true
  	mine.save!
  	render json: {error: 0}
  end

end