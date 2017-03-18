# Describe contact model definition
class Contact < ApplicationRecord
  belongs_to :manager, class_name: 'Contact', required: false

  enum gender: [:male, :female]

  scope :orphans, -> { where(manager_id: nil) }
end
