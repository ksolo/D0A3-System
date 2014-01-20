class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :sex
      t.date :dob
      t.string :family_roll
      t.integer :mother_id
      t.integer :father_id
      t.integer :family_id

      t.timestamps
    end
  end
end
