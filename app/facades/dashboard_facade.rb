class DashboardFacade

  def initialize(current_user)
    @current_user = current_user
    @_repos
    @_followers
  end

  def repos
    if @current_user.token
      repos_result.map do |repo_data|
        Repo.new(repo_data)
      end
    else
      nil
    end
  end

  def followers
    if @current_user.token
      followers_result.map do |follower_data|
        Follower.new(follower_data)
      end
    else
      nil
    end
  end

  private

  def service
    GithubService.new({ :oath_key => @current_user.token })
  end

  def repos_result
    @_repos ||= service.response_repos
  end

  def followers_result
    @_followers ||= service.response_followers
  end
end
