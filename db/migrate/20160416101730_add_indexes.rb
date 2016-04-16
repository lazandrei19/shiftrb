class AddIndexes < ActiveRecord::Migration
  def change
    add_index :projects, :hashed_id
    add_index :projects, :user_id
    add_index :workplaces, :user_id
    add_index :feedbacks, :project_id
  end
end