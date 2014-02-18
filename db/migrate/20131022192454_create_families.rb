class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.boolean  :status
	    t.integer  :responsible_id
	    t.text     :observations


      t.timestamps
    end

    add_index :families, :name, unique: true
  end
end