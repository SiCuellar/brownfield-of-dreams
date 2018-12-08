class DashboardFacade

  def initialize(current_user)
    @current_user = current_user
    @_repos
  end

  def repos
    if response_valid?(search_result.response_repos)
      search_result.response_repos.map do |repo_data|
        Repo.new(repo_data)
      end
    else
      []
    end
  end



  def followers
    if response_valid?(search_result.response_followers)
      search_result.response_followers.map do |follower_data|
        Follower.new(follower_data)
      end
    else
      []
    end
  end

  def following
    if response_valid?(search_result.response_followings)
      search_result.response_followings.map do |follower_data|
        Follower.new(follower_data)
      end
    else
      []
    end
  end

  def service
    GithubService.new({ :oath_key => @current_user.token })
  end

  def search_result
    @_search_result ||= service
  end

  private

  def response_valid?(response)
    if response.class == Array
      true
    else
      false
    end
  end
end
