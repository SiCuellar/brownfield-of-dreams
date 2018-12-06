require 'rails_helper'

describe 'User' do

  it 'user can see github repos on dashboard' do
    stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token abc"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    user = create(:user, token: "abc")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    all(".repo").first do
      expect(page).to have_css(".repo")
      expect(page).to have_content("Repo Name:")
      expect(page).to have_content("Url:")
      click_on 'http://'
      expect(current_url).to include('www.github.com/')
    end

  end

  it "user can't see other users repos " do
    user_1 = create(:user, token: "abc")
    user_2 = create(:user, token: "xyz")

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    stub = stub_request(:any, "https://api.github.com/user/repos").
      with(headers: { 'Authorization' => "token xyz"}).
    to_return(body: File.read("./spec/fixtures/github_repos.json"))

    expect{ visit(dashboard_path) }.to  raise_error(ActionView::Template::Error)
  end

  it "user can't see repos without token " do
    user_1 = create(:user, token: "abc")
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_2}

    visit(dashboard_path)

    expect(page).to_not have_css(".repo")
    expect(page).to_not have_content("Repo Name:")
    expect(page).to_not have_content("Url:")
  end
end
