# Add avatar paperclip attachment to contacts table
class AddAvatarToContact < ActiveRecord::Migration[5.0]
  def change
    add_attachment :contacts, :avatar
  end
end
