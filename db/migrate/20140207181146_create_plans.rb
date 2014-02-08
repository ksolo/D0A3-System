class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :lecture_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
