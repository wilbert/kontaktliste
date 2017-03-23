# Define Contact JSON payload in API.
class ContactSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper

  cache key: 'contact', expires_in: 3.hours

  attributes :id, :name, :email, :phone, :mobile, :manager_id, :gender
  attributes :postal_address, :zipcode_city, :country, :avatar
  attributes :face_center_x, :face_center_y, :children

  def children
    object.children.map(&:id)
  end

  def zipcode_city
    "#{object.zipcode} #{object.city.name}"
  end

  def country
    object.city.state.acronym
  end

  def avatar
    object.avatar.url(:thumb)
  end
end
