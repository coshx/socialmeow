class ApiController < ApplicationController
  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

private

	def twitter_client		
    Twitter::REST::Client.new do |config|
      config.consumer_key        = current_user.credentials.find_by(name:'api_key').code
      config.consumer_secret     = current_user.credentials.find_by(name:'api_secret').code
      config.access_token        = current_user.credentials.find_by(name:'access_token').code
      config.access_token_secret = current_user.credentials.find_by(name:'access_token_secret').code
    end
	end

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
