require 'rails_helper'

describe 'User ' do
  it 'user can send an invite' do

    expected_username = JSON.parse(File.read("./spec/fixtures/github_user_information.json"))['login']

    stub_request(:any, "https://api.github.com/users/#{expected_username}").
      with(headers: { 'Authorization' => "token abc"}).
      to_return(body: File.read("./spec/fixtures/github_user_information.json"))

    user_1 = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    within(".email-friend-invite")do
      click_link("Send an Invite")
    end

    expect(current_path).to eq("/invite")
    fill_in "github", with: expected_username

    click_on("Send Invite")
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully sent invite!")
  end

  

end
