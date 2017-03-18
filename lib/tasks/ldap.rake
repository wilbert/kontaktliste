require 'ldap/importer'

namespace :ldap do
  desc "Import contacts"
  task import: [:environment] do
    Ldap::Importer.import!
  end
end
