require 'rails_helper'

RSpec.describe 'Visitor' do

  it 'cant see tutorials marked as classroom content' do
    tutorial_1 = create(:tutorial, classroom: true)
    tutorial_2 = create(:tutorial, classroom: false)

    visit root_path
    expect(page).to have_content(tutorial_2.title)
    expect(page).to_not have_content(tutorial_1.title)
  end

end
