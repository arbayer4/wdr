if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_wdr_app", domain: :all, :tld_length => 2, same_site: :none, secure: true
else
  Rails.application.config.session_store :cookie_store, key: "_wdr_app"
end
