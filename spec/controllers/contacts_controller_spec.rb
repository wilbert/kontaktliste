require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let!(:contact1) { create(:contact, name: 'Mia Bradley') }
  let!(:contact2) { create(:contact, name: 'Marvin Hanson') }

  describe "GET #index" do
    before { get :index }
    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:contacts)).to eq([contact1, contact2]) }
  end

  describe "GET #index with query" do
    before { get :index, params: { q: { name_cont: 'mia' } } }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:contacts)).to eq([contact1]) }
  end
end
