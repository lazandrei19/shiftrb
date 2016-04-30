class AddProjectIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :project_id, :integer
    add_index :members, :project_id
  end
end
