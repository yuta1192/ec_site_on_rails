Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,ENV['TWITTER_CLIENT_ID'],ENV['TWITTER_CLIENT_SECRET']
  provider :facebook,ENV['FACEBOOK_CLIENT_ID'],ENV['FACEBOOK_CLIENT_SECRET']
  provider :google_oauth2,ENV['GOOGLE_CLIENT_ID'],ENV['GOOGLE_CLIENT_SECRET']
  provider :github,ENV['GITHUB_CLIENT_ID'],ENV['GITHUB_CLIENT_SECRET']

  # 下記を追加
  {:provider_ignores_state => true}
end
