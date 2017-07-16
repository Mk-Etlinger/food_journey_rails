class RemoveOccuredAtFromReactionLogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :reaction_logs, :occured_at, :datetime
  end
end
