# frozen_string_literal: true
require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.ignore_localhost = false
end
