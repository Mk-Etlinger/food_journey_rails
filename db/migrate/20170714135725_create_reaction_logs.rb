class CreateReactionLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :reaction_logs do |t|
      t.references :reaction, foreign_key: true
      t.integer :severity
      t.string :notes
      t.integer :stress_level
      t.datetime :occured_at

      t.timestamps
    end
  end
end
