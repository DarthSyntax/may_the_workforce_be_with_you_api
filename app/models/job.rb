class Job < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :employer

  validates :title, presence: true, length: {minimum: 4}
  validates :description, presence: true
  validates :exp_level, presence: true
end
