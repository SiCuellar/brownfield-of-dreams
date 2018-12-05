class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  belongs_to :github_credential

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password
end
