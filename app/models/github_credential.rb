class GithubCredential < ApplicationRecord
  belongs_to :user
  validates_presence_of :key
end
