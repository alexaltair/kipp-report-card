class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.integer :school_id
      t.string :type
      t.integer :grade_level
      t.integer :course_id

      t.timestamps
    end
  end
end

