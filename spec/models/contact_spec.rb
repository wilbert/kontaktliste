require 'rails_helper'
require 'ldap/person'

RSpec.describe Contact, type: :model do
  let!(:parent) { create(:contact, dn: 'uid=3,ou=People,dc=ecorp,dc=org') }
  let!(:child) { create(:contact, manager: parent, dn: 'uid=4,ou=People,dc=ecorp,dc=org') }
  let!(:other_parent) { create(:contact, dn: 'uid=1,ou=People,dc=ecorp,dc=org' ) }

  it { expect(Contact.orphans).to_not include(child) }

  describe 'callbacks' do
    describe '#after_save' do
      it 'should update manager when contact is saved' do
        person_4 = Ldap::Person.search(child.dn)
        person_4.update_manager(parent.dn)
        child.manager = other_parent
        child.save!
        expect(Ldap::Person.search(child.dn).manager.dn).to eq('uid=1,ou=People,dc=ecorp,dc=org')
        person_4.update_manager(parent.dn)
      end
    end
  end
end
