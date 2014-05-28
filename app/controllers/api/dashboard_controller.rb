class Api::DashboardController < ApiController
  before_action :authenticate_user!

  def index
    result = {}
    result[:accounts] = current_user.accounts.where.not(parent: nil).count
    result[:accounts_followed] = current_user.accounts.where(followed: true, following: false).count
    result[:accounts_followed_back] = current_user.followed_back.count
  	render json: [result].to_json
  end

end
