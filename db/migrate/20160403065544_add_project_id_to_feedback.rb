class AddProjectIdToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :project_id, :integer
    add_index :feedbacks, :project_id
  end
end
