class AddHashedIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :hashed_id, :string
    add_index :users, :hashed_id
  end
end
