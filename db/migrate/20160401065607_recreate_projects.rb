class RecreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string    :hashed_id
      t.string    :name
      t.string    :headline
      t.text      :description
      t.integer   :user_id

      t.timestamps null: false
    end
  end
end
