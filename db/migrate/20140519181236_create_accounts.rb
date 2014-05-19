class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :smid
      t.integer :user_id
      t.boolean :followed
      t.boolean :unfollowed
      t.boolean :followed_back
      t.string :parent
      t.datetime :followed_date
      t.datetime :unfollowed_date
      t.string :name
      t.string :handle
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
