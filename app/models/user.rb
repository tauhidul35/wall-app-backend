class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable
         #, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, :rememberable

  validates :email, presence: true, uniqueness: true
end
