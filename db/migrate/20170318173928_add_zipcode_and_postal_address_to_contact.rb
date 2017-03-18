class AddZipcodeAndPostalAddressToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :zipcode, :integer
    add_index :contacts, :zipcode
    add_column :contacts, :postal_address, :string
  end
end
