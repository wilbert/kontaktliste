require 'rails_helper'

RSpec.describe Contact, type: :model do
  let!(:parent) { create(:contact) }
  let!(:child) { create(:contact, manager: parent) }

  it { expect(Contact.orphans).to_not include(child) }
end
