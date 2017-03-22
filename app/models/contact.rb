require 'ldap/person'

# Describe contact model definition
class Contact < ApplicationRecord
  belongs_to :manager, class_name: 'Contact', required: false
  belongs_to :city

  has_many :children, class_name: 'Contact', foreign_key: :manager_id

  enum gender: [:male, :female]

  scope :orphans, -> { where(manager_id: nil) }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  # after_save :update_manager

  private

  def update_manager
    if manager_id_changed?
      person = Ldap::Person.search(dn)
      person.update_manager(manager.dn)
    end
  end
end
