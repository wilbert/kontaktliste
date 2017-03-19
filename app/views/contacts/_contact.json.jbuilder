json.extract! contact, :id, :name, :email, :phone, :mobile, :manager_id, :gender, :postal_address
json.zipcode_city "#{contact.zipcode} #{contact.city.name}"
json.country contact.city.state.acronym
json.avatar asset_url(contact.avatar.url(:thumb))
json.children do |json|
  json.array! contact.children, partial: 'contact', as: :contact
end
