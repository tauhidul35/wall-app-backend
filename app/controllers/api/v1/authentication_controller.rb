class Api::V1::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      json_response({
          success: true,
          user: command.result[:user].slice(:email, :name),
          auth_token: command.result[:token]
      }, :ok)
    else
      json_response({
          success: false,
          message: command.errors[:message].join('. ')
      }, :unauthorized)
    end
  end
end
