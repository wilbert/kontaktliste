require 'spec_helper'

describe 'Contacts' do
  include Features::RequestHelpers

  let!(:params) { { format: :json } }
  let!(:parent) { create(:contact, name: 'Mia Bradely') }
  let!(:contact) { create(:contact, name: 'Marvin Hanson', manager: parent) }

  describe 'GET /contacts' do
    let!(:url) { api_v1_contacts_path }

    before do
      do_action
    end

    it { expect(response.status).to be(200) }
    it { expect(@json['contacts'].size).to eq(1) }
    it { expect(@json['contacts'][0]['name']).to eq('Mia Bradely') }
    it { expect(@json['contacts'][0]['avatar']).to match(/avatar\.png/) }
    it { expect(@json['contacts'][0]['zipcode_city']).to_not be_nil }
    it { expect(@json['contacts'][0]['children']).to_not be_empty }
  end

  describe 'GET /contacts/:id' do
    let!(:url) { api_v1_contact_path(parent) }

    before do
      do_action
    end

    it { expect(response.status).to be(200) }
    it { expect(@json['name']).to eq('Mia Bradely') }
    it { expect(@json['avatar']).to match(/avatar\.png/) }
    it { expect(@json['zipcode_city']).to_not be_nil }
    it { expect(@json['children']).to_not be_empty }
  end
end
