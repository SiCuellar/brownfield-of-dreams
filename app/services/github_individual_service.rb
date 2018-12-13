class GithubIndividualService

  def initialize(g_user, oath_key)
    @g_user = g_user
    @oath_key = oath_key
  end

  def response_specific_user
    get_json("users/#{@g_user}")
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
