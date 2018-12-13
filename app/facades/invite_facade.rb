class InviteFacade

  def initialize(g_user, current_user)
    @g_user = g_user
    @current_user = current_user
    @_current_user_search_result
    @_prospect_search_result
  end

  def prospect_name
    prospect_search_result.response_specific_user[:name]
  end

  def user_name
    current_user_search_result.response_specific_user[:name]
  end

  def prospect_email
    prospect_search_result.response_specific_user[:email]
  end

  private


  def current_user_search_result
    @_current_user_search_result ||= service(@current_user.gusername)
  end

  def prospect_search_result
    @_prospect_search_result ||= service(@g_user)
  end

  def service(g_username)
    GithubIndividualService.new(g_username, @current_user.token)
  end

end
