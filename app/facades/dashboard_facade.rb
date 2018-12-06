class DashboardFacade

  def initialize(current_user)
    @current_user = current_user
    @_repos
  end

  def repos
    if @current_user.token
      search_result.response_repos.map do |repo_data|
        Repo.new(repo_data)
      end
    else
      nil
    end
  end

  def followers
    if @current_user.token
      search_result.response_followers.map do |follower_data|
        Follower.new(follower_data)
      end
    else
      nil
    end
  end

  def following
    if @current_user.token
      search_result.response_followings.map do |follower_data|
        Follower.new(follower_data)
      end
    else
      nil
    end
  end

  def service
    GithubService.new({ :oath_key => @current_user.token })
  end

  def search_result
    @_search_result ||= service
  end
end
