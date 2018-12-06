require 'rails_helper'

describe 'User' do

  it 'user can see github followers on dashboard' do

    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    stub_request(:any, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    stub_request(:any, "https://api.github.com/user/following").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_following.json"))

    user = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    within(".github-info") do
      within(".followers") do
        within first(".follower") do
          expect(page).to have_content("User Name:")
          # first(".user-link").click
          # expect(current_url).to include('www.github.com/')
        end
      end
    end
  end

  it 'user can see users they are following on dashboard' do

    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    stub_request(:any, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    stub_request(:any, "https://api.github.com/user/following").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_following.json"))

    user = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    within(".github-info") do
      within(".following") do
        within first(".follower") do
          expect(page).to have_content("User Name:")
          # first(".user-link").click
          # expect(current_url).to include('www.github.com/')
        end
      end
    end
  end
end
