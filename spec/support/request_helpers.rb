module Features
  module RequestHelpers
    def do_action(parameters={})
      get url, params.merge(parameters)
      @json = JSON.parse(response.body)
    end
  end
end


RSpec.configure do |config|
  config.include Features::RequestHelpers, type: :feature
end
