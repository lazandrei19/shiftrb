class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.string :company
      t.string :position
      t.integer :startYear
      t.integer :endYear
      t.boolean :current

      t.timestamps null: false
    end
  end
end
