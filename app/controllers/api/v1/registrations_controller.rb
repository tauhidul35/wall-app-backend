class Api::V1::RegistrationsController < Api::ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.create(sign_up_params)

    if user.errors.present?
      json_response({
                        success: false,
                        messages: user.errors.full_messages.join('. ')
                    }, :not_acceptable)
    else
      json_response({
                        success: true,
                        user: user.slice(:email, :name),
                        messages: find_message(:signed_up)
                    }, :created)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :name)
  end
end
