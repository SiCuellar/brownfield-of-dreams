require 'rails_helper'

describe "User " do
  it "user can add existing github friends" do
    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    stub_request(:any, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    stub_request(:any, "https://api.github.com/user/following").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_following.json"))

    user_1 = create(:user, token: "abc", uid: 12345)
    user_2 = create(:user, token: "def", uid: 27649011)
    user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path
    save_and_open_page

    within("User-#{user_2.id}") do
      expect(page).to have_button("Follow User")
    end

    within("User-#{user_3.id}") do
      expect(page).to_not have_button("Follow User")
    end
  end
end
