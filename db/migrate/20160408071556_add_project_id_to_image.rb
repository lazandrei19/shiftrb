class AddProjectIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :project_id, :integer
    add_index :images, :project_id
  end
end
