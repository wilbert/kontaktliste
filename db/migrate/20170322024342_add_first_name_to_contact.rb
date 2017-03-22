# Add first name column to contacts table.
class AddFirstNameToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :first_name, :string
  end
end
