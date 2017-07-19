class AddOccurredAtToReactions < ActiveRecord::Migration[5.1]
  def change
    add_column :reactions, :occurred_at, :datetime
  end
end
