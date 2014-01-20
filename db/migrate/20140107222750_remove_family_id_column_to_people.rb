class RemoveFamilyIdColumnToPeople < ActiveRecord::Migration
  def change
    remove_column :people, :family_id, :integer
  end
end
