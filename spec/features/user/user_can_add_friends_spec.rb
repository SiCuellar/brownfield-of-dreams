require 'rails_helper'

describe "User " do
  it "user can see link to existing github friends" do
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
    # TODO does this test need to not be reliant on mock data?
    user_2 = create(:user, token: "def", uid: 27649011)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    expect(page).to have_button("Add as Friend")
  end

  it "user can add friend" do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    within '.followers' do
      click_button 'Add as Friend'
    end

    expect(current_path).to eq(dashboard_path)
    within '.friends' do
      expect(page).to have_content(user_2.first_name)
    end
  end

  it "user sees error message if invalid user id is sent " do
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

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    page.driver.post("#{new_friendship_path}?uid=4545")
    click_on("redirect")
    expect(page).to have_content("Not a Valid User")
  end
end
