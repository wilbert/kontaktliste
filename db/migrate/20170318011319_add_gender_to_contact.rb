class AddGenderToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :gender, :integer
  end
end
