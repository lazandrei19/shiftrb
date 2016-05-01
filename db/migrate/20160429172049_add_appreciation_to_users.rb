class AddAppreciationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :appreciation, :integer
  end
end
