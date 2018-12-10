class Follower
  attr_reader :login,
              :url,
              :uid

  def initialize(followers_data)
    @login = followers_data[:login]
    @url = followers_data[:html_url]
    @uid = followers_data[:id]
  end

  def friendable?
    return true if User.find_by(uid: @uid)
    false
  end
end
