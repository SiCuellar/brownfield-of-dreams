require 'rails_helper'

RSpec.describe Follower do

  describe 'instace methods' do
    describe '.friendable?' do

      it 'can return true' do

        create(:user, token: 'aaa123', uid: 4321)
        follower_data = {
          id: 4321,
          login: 'test',
          html_url: 'www.github.com/test'
        }
        follower = Follower.new(follower_data)

        expect(follower.friendable?).to eq(true)
      end

      it 'can return false' do
        create(:user, token: 'aaa123', uid: 1234)
        follower_data = {
          id: 4321,
          login: 'test',
          html_url: 'www.github.com/test'
        }
        follower = Follower.new(follower_data)

        expect(follower.friendable?).to eq(false)
      end
    end
  end

end
