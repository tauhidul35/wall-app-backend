class Api::ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :set_current_api_user
  before_action :authenticate_request
  attr_reader :current_api_user

  private

  def set_current_api_user
    @current_api_user = AuthorizeApiRequest.call(request.headers).result
  end

  def authenticate_request
    error_response('Authentication failed', :unauthorized) unless @current_api_user
  end
end
