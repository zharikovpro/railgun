require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:html, :json]
  config.curl_host = 'http://localhost:5000'
  config.api_name = 'API Documentation'
  config.curl_headers_to_filter = %w(Host Cookie)
  config.request_headers_to_include = %w(Content-Type Authentication)
  config.response_headers_to_include = %w(Content-Type)
  config.request_body_formatter = :json
=begin
  config.define_group :developers do |d|
    d.request_body_formatter = :json
    d.filter = :developers
  end
  config.define_group :public  do |p|
    p.request_body_formatter = nil
    p.filter = :public
  end
=end
end
