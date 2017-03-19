class ContactSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper

  cache key: 'contact', expires_in: 3.hours

  attributes :id, :name, :email, :phone, :mobile, :manager_id, :gender
  attributes :postal_address, :zipcode_city, :country, :avatar
  attributes :children

  def children
    self.object.children.map(&:id)
  end

  def zipcode_city
    "#{self.object.zipcode} #{self.object.city.name}"
  end

  def country
    self.object.city.state.acronym
  end

  def avatar
    "//#{Rails.application.secrets.domain_name}#{self.object.avatar.url(:thumb)}"
  end
end
