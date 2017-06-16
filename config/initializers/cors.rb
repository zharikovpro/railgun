Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/api/v1/*', headers: :any, methods: :any
    resource '/api/graphql/*', headers: :any, methods: :post
  end
end
