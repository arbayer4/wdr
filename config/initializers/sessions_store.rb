if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_wdr_app", domain: "wdr-bloomington.herokuapp.com", secure: true
else
  Rails.application.config.session_store :cookie_store, key: "_wdr_app"
end
