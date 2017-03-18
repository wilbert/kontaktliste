json.contacts do |json|
  json.array! @contacts, partial: 'contact', as: :contact
end
