class AddScoreToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :score, :integer
  end
end
