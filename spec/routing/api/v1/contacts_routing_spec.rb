require 'spec_helper'

RSpec.describe Api::V1::ContactsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/contacts').to route_to('api/v1/contacts#index')
    end

    it 'routes to #show' do
      expect(get: 'api/v1/contacts/1').to route_to('api/v1/contacts#show', id: '1')
    end

    it 'routes to #show' do
      expect(patch: 'api/v1/contacts/1').to route_to('api/v1/contacts#update', id: '1')
    end
  end
end
