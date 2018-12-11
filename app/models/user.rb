class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  belongs_to :github_credential, optional: true

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def add_friend(friend_uid)
    new_bff = User.find_by(uid: friend_uid)
    self.friends << new_bff
    self.save
  end
end
