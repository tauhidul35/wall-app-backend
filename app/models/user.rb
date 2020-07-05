class User < ApplicationRecord
  has_many :posts

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  after_create :send_admin_mail

  private

  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now
  end
end
