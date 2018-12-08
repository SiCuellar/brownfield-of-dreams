require 'rails_helper'
RSpec.describe 'User' do
  it 'can connect to github' do

    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    stub_request(:any, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    stub_request(:any, "https://api.github.com/user/following").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_following.json"))

    stub_omniauth
    user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path
    click_link "Connect to Github"


    expect(user_1.token).to eq('12345')
    expect(page).to have_content('Github Information')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({'credentials' => {'token' => '12345'}})
  end
end
