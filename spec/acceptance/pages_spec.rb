require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Pages' do
  header 'Host', 'localhost:5000/api'
  header 'Content-Type', 'application/json'

  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:user).api_token}" }
  }

  let!(:pages) {  create_list(:page, 2) }
  response_field :id, "page ID", 'Type' => 'Integer'
  response_field :slug, "Name of page", 'Type' => 'String'
  response_field :markdown, "Weight in kilograms", 'Type' => 'Text'

  get '/v1/pages' do
    example_request 'List pages' do
      explanation 'List all available pages'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq 2
    end
  end

  get '/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }

    example_request 'Get specific page' do
      explanation 'Get a page by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq page.name
    end
  end

  post '/v1/pages' do
    parameter :slug, "Slug of page", required: true, scope: :page
    parameter :markdown, "markdown text", required: false, scope: :page

    let(:slug) { 'faq' }
    let(:markdown) { 'something' }

    example_request 'Create page' do
      explanation 'Create the new page'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq slug
    end
  end

end