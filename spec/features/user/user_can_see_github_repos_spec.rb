require 'rails_helper'

describe 'User' do
  it 'user can see github repos on dashboard' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    within ".repo" do
      expect(page).to have_css(".repo")
      expect(page).to have_content("Repo Name:")
      expect(page).to have_content("Url:")
    end
  end
end
