module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response(e.message, :unprocessable_entity)
    end
  end
end
