class AddHashedIdToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :hashed_id, :string
  end
end
