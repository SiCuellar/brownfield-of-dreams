require 'rails_helper'

describe 'user can register' do
  it 'user can register' do
    user = build(:user)

    visit root_path

    click_link("Register")

    fill_in "Email", with: user.email
    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password

    click_button("Create Account")

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as #{user.first_name} #{user.last_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

  end

  it 'user enters wrong registeration informaiton' do
    user = build(:user)

    visit root_path

    click_link("Register")

    fill_in "Email", with: user.email
    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.first_name

    click_button("Create Account")

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Passwords do not match")
  end

  it 'shows activated status' do
    user = create(:user, status:true)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

    visit dashboard_path

    expect(page).to have_content("Status: Active")


  end
end
