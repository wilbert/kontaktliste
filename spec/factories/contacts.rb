FactoryGirl.define do
  factory :contact do
    name 'Mia Bradley'
    email 'mbradley@ecorp.org'
    phone '(389)-540-3920'
    mobile '(389)-541-3012'
    gender :female
    avatar Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec', 'fixtures', 'images', 'avatar.png')), 'image/png')
  end
end
