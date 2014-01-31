class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
		t.integer :child_id
		t.integer :tutor_id
		t.integer :group_id

		t.timestamps
    end
  end
end