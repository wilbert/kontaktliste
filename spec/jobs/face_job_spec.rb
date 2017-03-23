require 'rails_helper'

RSpec.describe FaceJob, type: :job do
  let!(:contact) { create(:contact) }
  let!(:valid_contact) { create(:contact, avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec', 'fixtures', 'images', 'kontaktliste_36.jpeg')), 'image/jpg')) }
  let!(:invalid_contact) { create(:contact, avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec', 'fixtures', 'images', 'kontaktliste_29.jpeg')), 'image/jpg')) }

  it 'should enqueue job' do
    expect do
      FaceJob.perform_later
    end.to have_enqueued_job(FaceJob)
  end

  it 'should perform with params' do
    expect do
      FaceJob.perform_later(contact.id)
    end.to have_enqueued_job.with(contact.id)
  end

  it 'should associate gender and eye position to contact', :vcr do
    FaceJob.perform_now(valid_contact.id)

    expect(valid_contact.reload.gender).to eq('male')
    expect(valid_contact.reload.face_center_x).to eq(51)
    expect(valid_contact.reload.face_center_y).to eq(58)
  end

  it 'should not associate gender and eye position to contact', :vcr do
    FaceJob.perform_now(invalid_contact.id)

    expect(invalid_contact.reload.face_center_x).to eq(nil)
    expect(invalid_contact.reload.face_center_y).to eq(nil)
  end

  it 'should trigger and RuntimeError', :vcr do
    allow_any_instance_of(Contact).to receive(:save!).and_raise(RuntimeError)

    FaceJob.perform_now(contact.id)

    expect(valid_contact.reload.gender).to_not eq('male')
  end
end
