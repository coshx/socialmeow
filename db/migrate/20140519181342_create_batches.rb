class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.boolean :unfollowed
      t.datetime :unfollowed_date

      t.timestamps
    end
  end
end
