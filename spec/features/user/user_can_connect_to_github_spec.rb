require 'rails_helper'

describe 'User' do
  it 'can connect to github' do
    stub_omniauth

    user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path
    click_link("Connect to Github")

    expect(user_1.token).to eq("12345")
    expect(page).to have_content("Github Information")

  end
end




def stub_omniauth
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"credentials" => {"token" => "12345"}})
end
