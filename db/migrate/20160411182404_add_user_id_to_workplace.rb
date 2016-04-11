class AddUserIdToWorkplace < ActiveRecord::Migration
  def change
    add_column :workplaces, :user_id, :integer
    add_index :workplaces, :user_id
  end
end
