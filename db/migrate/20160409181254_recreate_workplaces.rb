class RecreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.string :company
      t.string :position
      t.string :emoji, :limit => 1

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
