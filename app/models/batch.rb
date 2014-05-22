class Batch < ActiveRecord::Base
	has_many :accounts
	belongs_to :user
end
