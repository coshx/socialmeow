class AddIndexToAccounts < ActiveRecord::Migration
  def change
  	add_index :accounts, [:smid, :user_id], :unique => true
  end
end
