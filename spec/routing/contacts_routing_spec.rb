require 'spec_helper'

RSpec.describe ContactsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'contacts').to route_to('contacts#index')
    end

    it 'routes to #show' do
      expect(get: 'contacts/1').to route_to('contacts#show', id: '1')
    end

    it 'routes to #show' do
      expect(patch: 'contacts/1').to route_to('contacts#update', id: '1')
    end
  end
end
