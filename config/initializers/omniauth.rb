Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWIETRY_TWITTER_KEY'], ENV['TWIETRY_TWITTER_SECRET']
end
