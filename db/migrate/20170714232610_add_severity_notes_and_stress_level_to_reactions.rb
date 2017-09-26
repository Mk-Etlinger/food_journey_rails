class AddSeverityNotesAndStressLevelToReactions < ActiveRecord::Migration[5.1]
  def change
    add_column :reactions, :severity, :integer
    add_column :reactions, :stress_level, :integer
    add_column :reactions, :notes, :text
  end
end
