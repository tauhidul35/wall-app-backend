class Api::V1::RegistrationsController < Devise::RegistrationsController
  include Response
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save

    if resource.errors.present?
      json_response({
                        success: false,
                        messages: resource.errors.full_messages
                    }, :not_acceptable)
    else
      json_response({
                        success: true,
                        user: resource.slice(:email, :name),
                        messages: [find_message(:signed_up)]
                    }, :created)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :name)
  end
end
