class AddIndexToSpots < ActiveRecord::Migration
  def change
  	add_index :spots, [:child_id, :group_id], unique: true
  end
end
