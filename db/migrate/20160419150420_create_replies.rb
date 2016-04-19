class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :user_id
      t.integer :feedback_id

      t.timestamps null: false
    end
    add_index :replies, :user_id
    add_index :replies, :feedback_id
  end
end
