require 'spec_helper'

RSpec.describe FaceAnalyzer, :vcr do
  context 'valid_image' do
    subject { FaceAnalyzer.new('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/36/thumb/kontakliste_36.jpeg') }

    describe '#methods', :vcr do
      before { subject.call }
      it { expect(subject.first_face['topLeftX']).to eq(19) }
      it { expect(subject.gender).to eq(:male) }
      it { expect(subject.face_center_x).to eq(51) }
      it { expect(subject.face_center_y).to eq(58.8) }
    end
  end

  context 'invalid_image' do
    subject { FaceAnalyzer.new('http://s3.amazonaws.com/kontaktliste/production/images/contacts/avatars/29/thumb/kontakliste_29.jpeg?1489887766') }

    describe '#methods', :vcr do
      before { subject.call }
      it { expect(subject.first_face).to eq(nil) }
      it { expect(subject.gender).to eq(nil) }
      it { expect(subject.face_center_x).to eq(nil) }
      it { expect(subject.face_center_y).to eq(nil) }
    end
  end
end
