Rails.application.config.middleware.insert_before 0, Rack::Cors do

  allow do
    origins "https://bloomingtonwdr.com", "bloomingtonwdr.com", "www.bloomingtonwdr.com", "https://main--adorable-heliotrope-49d3d0.netlify.app/", "https://www.bloomingtonwdr.com", "http://localhost:3001", "http://localhost:3000"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end