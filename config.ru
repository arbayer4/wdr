# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

require 'rack/cors'
use Rack::Cors do


  allow do
    origins "https://bloomingtonwdr.com", "bloomingtonwdr.com", "www.bloomingtonwdr.com", "https://main--adorable-heliotrope-49d3d0.netlify.app/", "https://www.bloomingtonwdr.com", "http://localhost:3001"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end