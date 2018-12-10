Rails.application.config.middleware.use OmniAuth::Builder do

  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']

  # OmniAuth.config.test_mode = false
  # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"credentials" => {"token" => "12345"}})
end
