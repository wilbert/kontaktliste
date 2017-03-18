require 'ldap/person'

module Ldap
  class Importer
    def self.import!
      people = Ldap::Person.all

      puts 'Starting importing'

      people.each do |person|
        puts "Importing #{person.uid}"
        puts "Dn: #{person.dn}"
        puts "Manager: #{person.manager}"

        contact = Contact.find_or_create_by(uid: person.uid)
        contact.dn = person.dn
        contact.name = person.name
        contact.email = person.email
        contact.phone = person.phone
        contact.mobile = person.mobile
        contact.avatar = person.avatar
        contact.postal_address = person.postaladdress
        contact.zipcode = person.postalcode
        state = State.find_or_create_by(acronym: person.c)
        contact.city = City.find_or_create_by(state_id: state.id, name: person.l)
        contact.manager = Contact.find_by(uid: person.manager.uid) if person.manager
        contact.save!
      end
    end

    puts 'Finishing importing'
  end
end
