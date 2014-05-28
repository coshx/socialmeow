class Account < ActiveRecord::Base
	belongs_to :user
	belongs_to :batch
	cattr_accessor :current_user_id

	def was_mined
		Mine.where(handle: handle, mined: true, user_id: current_user_id).any?
	end
	def to_mine
		Mine.where(handle: handle, mined: nil, user_id: current_user_id).any?
	end
end
