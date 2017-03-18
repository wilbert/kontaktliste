# Describe contact model definition
class Contact < ApplicationRecord
  belongs_to :manager, class_name: 'Contact', required: false

  enum gender: [:male, :female]

  scope :orphans, -> { where(manager_id: nil) }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
