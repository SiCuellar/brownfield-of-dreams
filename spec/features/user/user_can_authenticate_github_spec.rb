require 'rails_helper'

RSpec.describe 'user can authenticate with github' do

  before(:each) do
    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    stub_request(:any, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    stub_request(:any, "https://api.github.com/user/following").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_following.json"))
  end

  it 'redirects to github' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}
    visit dashboard_path

  end

end
