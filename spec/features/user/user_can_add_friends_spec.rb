require 'rails_helper'

describe "User " do
  it "user can add existing github friends" do
    user_1 = create(:user, token: "abc")
    user_2 = create(:user, token: "def")
    user_3 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user_1}

    visit dashboard_path

    within("User #{user_2.uid}") do
      expect(page).to have_button("Follow User")
    end

    within("User #{user_3.uid}") do
      expect(page).to_not have_button("Follow User")
    end
  end
end
