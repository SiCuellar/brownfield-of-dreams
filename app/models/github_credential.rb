class GithubCredential < ApplicationRecord
  belongs_to :user, optional: true
  validates_presence_of :key
end
