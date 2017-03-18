require 'ldap/person'

module Ldap
  class Importer
    def self.import!
      people = Ldap::Person.all

      people.each do |person|
        contact = Contact.find_or_create_by(uid: person.uid)
        contact.name = person.name
        contact.email = person.email
        contact.phone = person.phone
        contact.mobile = person.mobile
        contact.avatar = person.avatar
        contact.save!
      end
    end
  end
end
