require 'rails_helper'

describe GithubService do
  it " Gets JSON data" do
    VCR.use_cassette("user_repos_casette") do
      service = GithubService.new({oath_key: ENV["github_key"]})

      expect(service.response_repos).to be_a(Array)
      expect(service.response_repos[0]).to have_key(:name)
      expect(service.response_repos[0]).to have_key(:owner)
      expect(service.response_repos[0]).to have_key(:full_name)
    end
  end

  
end
