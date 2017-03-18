require 'ldap/importer'
require 'rails_helper'

RSpec.describe Ldap::Importer, :vcr do
  describe 'methods', :vcr do
    it 'should create 59 contacts' do
      expect do
        Ldap::Importer.import!
      end.to change(Contact, :count).by(59)
    end
  end
end
