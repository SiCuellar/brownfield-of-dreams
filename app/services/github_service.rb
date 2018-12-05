class GithubService
  def initialize(params)
    @oath_key = params[:oath_key]
  end

  def response_repos
    get_json("/user/repos")
  end

  private

  def get_json(path)
    response = conn.get(path)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@oath_key}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
