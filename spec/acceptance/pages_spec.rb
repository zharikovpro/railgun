require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Pages', issues: [132] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:editor).api_token}" }
  let!(:pages) {  create_list(:page, 2) }
  response_field :id, 'page ID', 'Type' => 'Integer'
  response_field :slug, 'Name of page', 'Type' => 'String'
  response_field :markdown, 'Weight in kilograms', 'Type' => 'Text'

  get '/api/v1/pages' do
    example_request 'List pages' do
      explanation 'List all available pages'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq 2
    end
  end

  get '/api/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }

    example_request 'Get specific page' do
      explanation 'Get a page by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq page.slug
    end
  end

  post '/api/v1/pages' do
    parameter :slug, 'Slug', required: true, scope: :page
    parameter :markdown, 'markdown', required: false, scope: :page

    let(:slug) { 'faq' }
    let(:markdown) { 'something' }

    example_request 'Create page' do
      explanation 'Create the new page'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq slug
    end
  end
end
