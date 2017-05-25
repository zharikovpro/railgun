require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Pages', issues: [132] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:editor).api_token}" }
  let!(:pages) { create_list(:page, 2) }
  response_field :id, 'page ID', 'Type' => 'Integer'
  response_field :slug, 'Name of page', 'Type' => 'String'
  response_field :markdown, 'Text safe convert to html tags', 'Type' => 'Text'

  get '/api/v1/pages' do
    example_request 'List pages' do
      explanation 'List all available pages'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq(2)
    end
  end

  get '/api/v1/pages/-1' do
    example_request 'resource not found' do
      explanation 'returns status 404'

      expect(status).to eq 404
    end
  end

  get '/api/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }

    example_request 'Get specific page' do
      explanation 'Get a page by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq(page.slug)
    end
  end

  post '/api/v1/pages' do
    parameter :slug, 'Slug'
    parameter :markdown, 'Markdown'

    let(:slug) { 'faq' }
    let(:markdown) { 'something' }

    let(:raw_post) { params.to_json }

    example_request 'Create page' do
      explanation 'Create the new page'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq('faq')
      expect(Page.find_by_slug(:faq).markdown).to eq('something')
    end
  end

  put '/api/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }

    parameter :slug, 'Slug'
    parameter :markdown, 'Markdown'

    let(:slug) { 'about' }
    let(:markdown) { 'new content' }

    let(:raw_post) { params.to_json }

    example_request 'Update page' do
      explanation 'Update page with new content'
      do_request

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq('about')
      expect(Page.find_by_slug(:about).markdown).to eq('new content')
    end
  end

  put '/api/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }

    parameter :slug, '%%^^##'
    parameter :markdown, 'bad request'

    let(:slug) { '%%^^##' }
    let(:markdown) { 'bad request' }

    let(:raw_post) { params.to_json }

    example_request 'Error when updates page' do
      explanation 'Params of page is not valid'

      expect(status).to eq 422
      expect(JSON.parse(response_body)['slug']).not_to eq('%%^^##')
    end
  end

  delete '/api/v1/pages/:id' do
    let(:page) { pages.first }
    let(:id) { page.id }
    example_request 'Delete page' do
      explanation 'Deletes page and returns status 204'

      expect(status).to eq 204
      expect(Page.find_by_id(page.id)).to be_nil
    end
  end
end
