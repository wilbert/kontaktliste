require 'rails_helper'
require 'ldap/person'

RSpec.describe Contact, type: :model do
  let!(:parent) { create(:contact, dn: 'uid=3,ou=People,dc=ecorp,dc=org') }
  let!(:child) { create(:contact, manager: parent, dn: 'uid=4,ou=People,dc=ecorp,dc=org') }
  let!(:other_parent) { create(:contact, dn: 'uid=1,ou=People,dc=ecorp,dc=org' ) }

  it { expect(Contact.orphans).to_not include(child) }
end
