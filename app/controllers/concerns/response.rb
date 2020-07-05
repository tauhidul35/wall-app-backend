module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def success_response(object, status = :ok)
    json_response(object.merge!(success: true), status)
  end

  def error_response(message, status = :not_acceptable)
    json_response({success: false, message: message}, status)
  end
end
