require 'rails_helper'

RSpec.describe FaceJob, type: :job do
  let!(:contact) { create(:contact) }

  it 'should enqueue job' do
    expect {
      FaceJob.perform_later
    }.to have_enqueued_job(FaceJob)
  end

  it 'should perform with params' do
    expect {
      FaceJob.perform_later('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/36/thumb/kontakliste_36.jpeg', contact.id)
    }.to have_enqueued_job.with('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/36/thumb/kontakliste_36.jpeg', contact.id)
  end

  it 'should associate gender and eye position to contact', :vcr do
    FaceJob.perform_now('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/36/thumb/kontakliste_36.jpeg', contact.id)
    expect(contact.reload.gender).to eq('male')
    expect(contact.reload.face_center_x).to eq(51)
    expect(contact.reload.face_center_y).to eq(58)
  end

  it 'should not associate gender and eye position to contact', :vcr do
    FaceJob.perform_now('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/29/thumb/kontakliste_29.jpeg', contact.id)
    expect(contact.reload.face_center_x).to eq(nil)
    expect(contact.reload.face_center_y).to eq(nil)
  end
end
