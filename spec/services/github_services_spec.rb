require 'rails_helper'

describe GithubService do
  it " Gets JSON data" do
    VCR.use_cassette("user_repos_casette") do

      service = GithubService.new({oath_key: ENV["github_key"]})
      binding.pry

      

    end

  end
end
