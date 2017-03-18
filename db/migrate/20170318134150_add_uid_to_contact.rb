# Add UID column to contacts table
class AddUidToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :uid, :string
    add_index :contacts, :uid
  end
end
