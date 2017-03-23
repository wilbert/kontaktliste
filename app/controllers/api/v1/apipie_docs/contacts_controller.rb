module Api
  module V1
    module ApipieDocs
      # Decribe API::V1::Contacts resource api docs.
      module ContactsController
        def apipie_index
          api :GET, '/v1/contacts', 'List all available contacts'
          formats ['json']
          description 'Retrieve a list of contacts and association represented in JSON'
          param :q, Hash, desc: 'Query params for search and sorting using arel', required: false
          api_version '1'
        end
      end
    end
  end
end
