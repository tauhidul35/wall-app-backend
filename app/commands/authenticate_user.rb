class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    { user: api_user, token: JsonWebToken.encode(user_id: api_user.id) } if api_user
  end

  private

  attr_accessor :email, :password

  def api_user
    user = User.find_by_email(email)
    unless user.present? && user.valid_password?(password)
      errors.add :message, 'Invalid email or password'
      return nil
    end

    user
  end
end
