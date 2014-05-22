class AddSmidToMines < ActiveRecord::Migration
  def change
    add_column :mines, :smid, :string
  end
end
