# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('832010478415-ugp0o039v71f8kv1334rckru6tegj2qa.apps.googleusercontent.com', nil),
           ENV.fetch('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', nil)
end
