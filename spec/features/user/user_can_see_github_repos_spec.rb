require 'rails_helper'

describe 'User' do

  it 'user can see github repos on dashboard' do
    stub_request(:any, "https://api.github.com/user/repos").
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    all(".repo").first do
      expect(page).to have_css(".repo")
      expect(page).to have_content("Repo Name:")
      expect(page).to have_content("Url:")
    end
  end

  # it "user can't see repos without a token " do
  #   user = create(:user)
  #
  #   allow_any_instance_of(ApplicationController).to receive(:current_user) {user}
  #
  #   user.github_credential
  # end
end
