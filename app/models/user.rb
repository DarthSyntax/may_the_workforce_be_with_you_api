class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_and_belongs_to_many :jobs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :full_name, presence: true, length: {minimum: 3}

  def jwt_payload
    super
  end
end
