class RemoveMotherIdColumnToPeople < ActiveRecord::Migration
  def change
    remove_column :people, :mother_id, :integer
  end
end
