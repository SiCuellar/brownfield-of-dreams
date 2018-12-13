require 'rails_helper'

describe 'User ' do
  it 'user can send an invite' do
    user_1 = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    within(".email-friend-invite")do
      click_link("Send an Invite")
    end

    expect(current_path).to eq("/invite")
    fill_in "github", with: "prestonjarnagin"

    click_on("Send Invite")
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully sent invite!")

  end

end
