class Api::V1::RegistrationsController < Api::ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.create(sign_up_params)

    if user.errors.present?
      error_response(user.errors.full_messages.join('. '))
    else
      success_response({user: user.slice(:email, :name)}, :created)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :name)
  end
end
