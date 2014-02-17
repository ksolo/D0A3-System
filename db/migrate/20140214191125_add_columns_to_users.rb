class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :coordinator, :boolean
  	add_column :users, :facilitator, :boolean
  end
end