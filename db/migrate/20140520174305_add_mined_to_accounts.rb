class AddMinedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :mined, :boolean
    add_column :accounts, :following, :boolean
  end
end
