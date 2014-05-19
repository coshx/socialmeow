class AddBatchToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :batch_id, :integer
  end
end
