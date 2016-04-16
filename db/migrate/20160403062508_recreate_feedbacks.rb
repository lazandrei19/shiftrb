class RecreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :hashed_id
      t.text :content

      t.integer :project_id

      t.timestamps null: false
    end
  end
end
