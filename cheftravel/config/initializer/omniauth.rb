Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['832010478415-ugp0o039v71f8kv1334rckru6tegj2qa.apps.googleusercontent.com'], ENV['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']
end