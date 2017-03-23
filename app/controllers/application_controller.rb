# Define all default controller methods
class ApplicationController < ActionController::API
  before_action :set_default_response_format

  include ActionController::Caching

  private

  def set_default_response_format
    request.format = :json
  end
end
