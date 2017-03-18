class AddCityItToContact < ActiveRecord::Migration[5.0]
  def change
    add_reference :contacts, :city, foreign_key: true
  end
end
