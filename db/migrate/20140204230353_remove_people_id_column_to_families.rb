class RemovePeopleIdColumnToFamilies < ActiveRecord::Migration
  def change
    remove_column :families, :person_id, :integer
  end
end
