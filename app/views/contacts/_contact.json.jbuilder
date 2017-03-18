json.extract! contact, :id, :name, :email, :phone, :mobile, :manager_id, :gender
json.avatar contact.avatar.url
json.children do |json|
  json.array! contact.children, partial: 'contact', as: :contact
end
