class Account < ActiveRecord::Base
	belongs_to :user
	belongs_to :batch

	def was_mined
		Mine.where(handle: handle, mined: true).any?
	end
	def to_mine
		Mine.where(handle: handle, mined: nil).any?
	end
end
