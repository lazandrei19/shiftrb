class AddHeadlineToProject < ActiveRecord::Migration
  def change
    add_column :projects, :headline, :string
  end
end
