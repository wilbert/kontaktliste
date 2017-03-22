class AddSurnameToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :surname, :string
  end
end
