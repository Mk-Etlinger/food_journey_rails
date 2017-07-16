class AddOccurredAtToReactionLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :reaction_logs, :occurred_at, :datetime
  end
end
