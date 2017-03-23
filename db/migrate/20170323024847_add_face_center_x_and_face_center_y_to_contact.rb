class AddFaceCenterXAndFaceCenterYToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :face_center_x, :integer
    add_column :contacts, :face_center_y, :integer
  end
end
