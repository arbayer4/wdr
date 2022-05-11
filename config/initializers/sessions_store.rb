if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_wdr_app", domain: "https://www.bloomingtonwdr.com"
else
  Rails.application.config.session_store :cookie_store, key: "_wdr_app"
end
