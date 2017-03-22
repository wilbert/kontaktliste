require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  let!(:contact1) { create(:contact, name: 'Mia Bradley') }
  let!(:contact2) { create(:contact, name: 'Marvin Hanson') }

  describe 'GET #index' do
    before { get :index }
    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:contacts)).to eq([contact1, contact2]) }
  end

  describe 'GET #index with query' do
    before { get :index, params: { q: { name_cont: 'mia' } } }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:contacts)).to eq([contact1]) }
  end

  describe 'PATCH #update' do
    describe 'with valid attributes' do
      let(:new_attributes) { { name: 'New contact name' } }

      before { patch :update, params: { id: contact1.to_param, contact: new_attributes } }

      it { expect(contact1.reload.name).to eq('New contact name') }
      it { expect(assigns(:contact)).to eq(contact1) }
      it { expect(response).to have_http_status(:success) }
    end

    describe 'with invalid attributes' do
      let(:invalid_attributes) { { name: nil } }

      before { allow_any_instance_of(Contact).to receive(:update).and_return(false) }

      before { patch :update, params: { id: contact1.id, contact: invalid_attributes } }

      it { expect(assigns(:contact)).to eq(contact1) }
      it { expect(response).to_not have_http_status(:success) }
    end
  end
end
