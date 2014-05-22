class AddHandleToMines < ActiveRecord::Migration
  def change
    add_column :mines, :handle, :string
  end
end
