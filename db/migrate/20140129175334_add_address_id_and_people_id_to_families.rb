class AddAddressIdAndPeopleIdToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :address_id, :integer
    add_column :families, :person_id, :integer
  end
end
