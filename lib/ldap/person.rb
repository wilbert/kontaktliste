module Ldap
  class Person
    include ActiveModel::Model
    include ActiveModel::Serialization

    attr_accessor :dn, :uid, :inetOrgPerson, :cn, :sn, :givenname
    attr_accessor :mail, :telephonenumber, :mobile, :postaladdress
    attr_accessor :postalcode, :l, :c, :jpegphoto, :manager

    alias_attribute :name, :givenname
    alias_attribute :email, :mail
    alias_attribute :phone, :telephonenumber

    def initialize(params = {})
      super(params)
      save_photo_file
    end

    def self.first
      all.first
    end

    def self.all
      treebase = "ou=people,dc=ecorp,dc=org"
      filter = Net::LDAP::Filter.eq('objectclass', 'inetOrgPerson')

      people = []

      Person.connection.search(base: treebase, filter: filter).each do |entry|
        person = Person.parse(entry)
        people.push(person)
      end

      return people
    end

    def avatar
      File.open(tmp_photo_path)
    end

    private

    def self.parse(entry)
      manager_entry = Person.connection.search(base: entry.first('manager')) if entry.first('manager')
      manager = parse(manager_entry.first) if manager_entry

      person = Ldap::Person.new(
        dn: entry.first('dn'),
        uid: entry.first('uid'),
        inetOrgPerson: entry.first('inetOrgPerson'),
        cn: entry.first('cn'),
        sn: entry.first('sn'),
        givenname: entry.first('givenname'),
        mail: entry.first('mail'),
        telephonenumber: entry.first('telephonenumber'),
        mobile: entry.first('mobile'),
        postaladdress: entry.first('postaladdress'),
        postalcode: entry.first('postalcode'),
        l: entry.first('l'),
        c: entry.first('c'),
        jpegphoto: entry.first('jpegphoto'),
        manager: manager
      )
    end

    def save_photo_file
      file = File.open(tmp_photo_path, 'wb')
      file.write(jpegphoto)
      file.close
    end

    def tmp_photo_path
      "/tmp/kontakliste_#{uid}.jpeg"
    end

    def self.connection
      Net::LDAP.new host: '0.0.0.0', port: 389, auth: { method: :simple, username: "cn=admin,dc=ecorp,dc=org", password: "supersecret" }
    end
  end
end
