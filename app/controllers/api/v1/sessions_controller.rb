class Api::V1::SessionsController < Devise::SessionsController
  include Response
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)

    if resource.errors.present?
      json_response({
                        success: false,
                        messages: resource.errors.full_messages
                    }, :unauthorised)
    else
      json_response({
                        success: true,
                        user: resource.slice(:email, :name),
                        token: request.env['warden-jwt_auth.token'],
                        messages: [find_message(:signed_in)]
                    }, :ok)
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def respond_to_on_destroy
    head :ok
  end
end
