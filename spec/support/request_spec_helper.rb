module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # Login via Devise
  def login(user = nil)
    user = user || FactoryBot.create(:user)
    AuthenticateUser.call(user.email, user.password).result # token
  end
end
