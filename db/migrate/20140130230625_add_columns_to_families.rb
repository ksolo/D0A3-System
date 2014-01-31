class AddColumnsToFamilies < ActiveRecord::Migration
  def change
  	add_column :families, :status, :boolean
  	add_column :families, :responsible_id, :integer
  	add_column :families, :observations, :text
  end
end
