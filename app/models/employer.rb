class Employer < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :jobs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true, length: {minimum: 12}

  def jwt_payload
    super
  end
end
