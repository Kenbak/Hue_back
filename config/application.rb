require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HueBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.





    config.session_store :cookie_store, key: '_hue_session'
    puts("Loading cookies session store KEY")

    puts("Loading cookies session store options")
    config.session_options = {
      httponly: true,
      same_site: "None",
      secure: Rails.env.production?
    }



    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    puts("Loading cookies ACTION DISPATCH")
    config.middleware.use ActionDispatch::Cookies

   #config.middleware.use ActionDispatch::Session::CookieStore
   puts("Loading cookies ALL")
    config.middleware.use config.session_store, config.session_options
  end
end
