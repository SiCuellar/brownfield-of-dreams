class Follower
  attr_reader :login,
              :url

  def initialize(followers_data)
    @login = followers_data[:login]
    @url = followers_data[:html_url]
  end
end
