class AddColumsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :email, :string
    add_column :users, :remember_token, :string
    add_column :users, :admin, :boolean
  end
end
