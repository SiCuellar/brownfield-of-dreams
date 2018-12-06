require 'rails_helper'

RSpec.describe GithubCredential, type: :model do
  describe "validations" do
    it { should validate_presence_of :key }
  end

  describe "relationships" do
    it { should belong_to :user }
  end

end
