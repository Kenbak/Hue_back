Rails.application.config.action_controller.forgery_protection_origin_check = false


puts("Loading CORS")
Rails.application.config.middleware.insert_before 0, Rack::Cors do
allow do
  origins 'localhost:5173'  # or the domain where your frontend is hosted
  resource '/api/*',
    headers: :any,
    methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true  # <-- Add this line
end
end
