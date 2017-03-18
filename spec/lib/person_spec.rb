require 'ldap/person'
require 'rails_helper'

RSpec.describe Ldap::Person, :vcr do
  subject { Ldap::Person }

  describe 'methods', :vcr do
    it { expect(subject.all.count).to_not eq(0) }
    it { expect(subject.first.uid).to_not be_nil }
    it { expect(subject.first.avatar).to_not be_nil }
  end
end
