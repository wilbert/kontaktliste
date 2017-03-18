# Add dn attribute to contacts column
class AddDnToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :dn, :string
    add_index :contacts, :dn
  end
end
