class RemoveAddressIdColumnToFamilies < ActiveRecord::Migration
  def change
    remove_column :families, :address_id, :integer
  end
end
