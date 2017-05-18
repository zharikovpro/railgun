require 'rails_helper'
require 'spec_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Pages', issues: [132] do
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  header 'Authorization', authenticated_header

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
      expect(JSON.parse(response_body)['slug']).to eq page.name
    end
  end

  post '/api/v1/pages' do
    parameter :slug, 'Slug of page', required: true, scope: :page
    parameter :markdown, 'markdown text', required: false, scope: :page

    let(:slug) { 'faq' }
    let(:markdown) { 'something' }

    example_request 'Create page' do
      explanation 'Create the new page'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq slug
    end
  end

end
=begin
require 'rails_helper'

RSpec.describe '/api/v1/pages', type: :request, issues: [116] do
  let!(:page) { create(:page) }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'POST /' do
    it 'creates a page' do
      post '/api/v1/pages', headers: authenticated_header, params: { slug: 'faq', markdown: 'something' }

      expect(response.parsed_body['slug']).to eq('faq')
      expect(Page.find_by_slug(:faq).markdown).to eq('something')
    end
  end

  describe 'PUT /:id' do
    it 'updates page with valid slug' do
      put "/api/v1/pages/#{page.id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Page.find_by_id(page.id).slug).to eq('about_1')
    end

    it 'slug cannot contain special chars' do
      put "/api/v1/pages/#{page.id}", headers: authenticated_header, params: { slug: '%%^^##' }

      expect(response).to have_http_status(422)
    end
  end
end
=end

=begin
resource "Pages" do
  get "pages" do
    parameter :page, "Page to view"

    # default :document is :all
    example "Get a list of all accounts" do
      do_request
      status.should == 200
    end
  end
end
=end
