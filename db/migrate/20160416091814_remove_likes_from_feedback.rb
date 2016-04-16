class RemoveLikesFromFeedback < ActiveRecord::Migration
  def change
    remove_column :feedbacks, :likes, :integer
  end
end
