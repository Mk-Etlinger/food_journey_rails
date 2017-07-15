class RemoveSeverityNotesAndStressLevelFromReactionLogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :reaction_logs, :severity, :integer
    remove_column :reaction_logs, :stress_level, :integer
    remove_column :reaction_logs, :notes, :string
  end
end
