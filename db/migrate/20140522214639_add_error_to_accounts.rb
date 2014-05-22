class AddErrorToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :error, :string
  end
end
