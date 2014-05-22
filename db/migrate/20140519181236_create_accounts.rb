class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :smid
      t.integer :user_id
      t.boolean :followed, default: false
      t.boolean :unfollowed, default: false
      t.boolean :followed_back, default: false
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
