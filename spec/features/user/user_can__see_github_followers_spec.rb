require 'rails_helper'
RSpec.describe 'User github followers section 'do

  it 'shows followers when authenticated' do
    stub_request(:get, "https://api.github.com/user/followers").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_followers.json"))

    user = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(page).to have_css(".followers")
    all(".follower").first do
      expect(page).to have_css(".follower")
      expect(page).to have_content("Username: ")
      click_on ("Username: ")
      expect(current_url).to include("www.github.com")
    end

  end

end
