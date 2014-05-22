class CreateMines < ActiveRecord::Migration
  def change
    create_table :mines do |t|
      t.integer :user_id
      t.boolean :mined

      t.timestamps
    end
  end
end
