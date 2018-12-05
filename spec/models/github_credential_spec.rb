require 'rails_helper'

RSpec.describe GithubCredential, type: :model do
  descirbe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :key }
  end

  descirbe "relationships" do
    it { should belong_to :user }
  end
  
end
