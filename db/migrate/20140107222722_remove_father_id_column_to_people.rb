class RemoveFatherIdColumnToPeople < ActiveRecord::Migration
  def change
    remove_column :people, :father_id, :integer
  end
end
