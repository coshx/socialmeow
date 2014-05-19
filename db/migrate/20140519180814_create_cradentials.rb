class CreateCradentials < ActiveRecord::Migration
  def change
    create_table :cradentials do |t|
      t.integer :user_id
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
