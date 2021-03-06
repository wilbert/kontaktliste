require 'ldap/person'
require 'rails_helper'

RSpec.describe Ldap::Person, :vcr do
  let!(:parent) { create(:contact, dn: 'uid=3,ou=People,dc=ecorp,dc=org') }
  let!(:child) { create(:contact, manager: parent, dn: 'uid=4,ou=People,dc=ecorp,dc=org') }
  let!(:other_parent) { create(:contact, dn: 'uid=1,ou=People,dc=ecorp,dc=org') }

  subject { Ldap::Person }

  describe 'methods', :vcr do
    it { expect(subject.all.count).to_not eq(0) }
    it { expect(subject.first.uid).to_not be_nil }
    it { expect(subject.first.avatar).to_not be_nil }
  end

  describe 'contacts callbacks' do
    describe '#after_save' do
      describe 'with an existent manager' do
        it 'should update manager when contact is saved' do
          person4 = Ldap::Person.search(child.dn)
          person4.update_manager(parent.dn)
          child.manager = other_parent
          child.save!
          person4 = Ldap::Person.search(child.dn)
          expect(person4.manager.dn).to eq(other_parent.dn)
        end
      end

      describe 'with an unexistent manager' do
        it 'should update manager when contact is saved' do
          person4 = Ldap::Person.search(child.dn)
          person4.update_manager(parent.dn)
          child.manager = nil
          child.save!
          person4 = Ldap::Person.search(child.dn)
          expect(person4.manager).to eq(nil)
        end
      end
    end
  end
end
