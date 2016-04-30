class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :members, :user_id
  end
end
