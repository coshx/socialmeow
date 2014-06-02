class Api::DashboardController < ApiController
  before_action :authenticate_user!

  def index
  	users = User.all  	
    results = []
    users.each do |u|
    	result = {}
	    followed = u.accounts.order(:followed_date).where(followed: true, following: false)
	    result[:name] = u.email
	    result[:accounts] = u.accounts.where.not(parent: nil).count
	    result[:accounts_followed] = followed.count
	    result[:accounts_followed_back] = u.followed_back.count
	    first_date = followed.first.followed_date
	    last_date = followed.last.followed_date
	    result[:days_of_work] = (last_date - first_date).to_i / 1.day
	    if result[:days_of_work] > 0
		    result[:followed_per_day] = result[:accounts_followed] / result[:days_of_work]
		    result[:followed_back_per_day] = result[:accounts_followed_back] / result[:days_of_work]
		end
	    results << result
   	end
  	render json: results.to_json
  end

end
