class AddIndexToPeopleNameAndLastNames < ActiveRecord::Migration
  def change
  	add_index :people, [ :name, :first_last_name, :second_last_name ], :unique => true
  end
end
