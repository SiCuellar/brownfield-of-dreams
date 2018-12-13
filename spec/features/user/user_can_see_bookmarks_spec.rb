require 'rails_helper'

RSpec.describe 'User' do

  it 'can see bookmarked videos' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user) {user}
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)

    video_1 = create(:video, tutorial: tutorial_1, position: 0)
    video_3 = create(:video, tutorial: tutorial_2, position: 1)
    video_2 = create(:video, tutorial: tutorial_1, position: 2)

    user.videos << video_1
    user.videos << video_2
    user.videos << video_3

    visit dashboard_path

    expect(page).to have_content("Bookmarked Segments")

    within all('.bookmark')[0] do
      expect(page).to have_content(video_1.title)
    end

    within all('.bookmark')[1] do
      expect(page).to have_content(video_2.title)
    end

    within all('.bookmark')[2] do
      expect(page).to have_content(video_3.title)
    end
  end
end
