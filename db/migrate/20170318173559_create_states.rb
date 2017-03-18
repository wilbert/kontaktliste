# Create states table
class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :acronym

      t.timestamps
    end

    add_index :states, :acronym
  end
end
