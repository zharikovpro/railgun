require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Snippets', issues: [132] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:developer).api_token}" }
  let!(:snippets) { create_list(:snippet, 2) }
  response_field :id, 'snippet ID', 'Type' => 'Integer'
  response_field :slug, 'Name of snippet', 'Type' => 'String'
  response_field :text, 'Text with workings html-tags', 'Type' => 'Text'

  get '/api/v1/snippets' do
    example_request 'List snippets' do
      explanation 'List all available snippets'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq(2)
    end
  end

  get '/api/v1/snippets/-1' do
    example_request 'resource not found' do
      explanation 'returns status 404'

      expect(status).to eq 404
    end
  end

  get '/api/v1/snippets/:id' do
    let(:snippet) { snippets.first }
    let(:id) { snippet.id }

    example_request 'Get specific snippet' do
      explanation 'Get a snippet by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq(snippet.slug)
    end
  end

  post '/api/v1/snippets' do
    parameter :slug, 'Slug'
    parameter :text, 'Text'

    let(:slug) { 'faq' }
    let(:text) { 'something' }
    let(:raw_post) { params.to_json }

    example_request 'Create snippet' do
      explanation 'Create the new snippet'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq('faq')
      expect(Snippet.find_by_slug(:faq).text).to eq('something')
    end
  end

  put '/api/v1/snippets/:id' do
    let(:snippet) { snippets.first }
    let(:id) { snippet.id }
    parameter :slug, 'Slug'
    parameter :text, 'Text'

    let(:slug) { 'about' }
    let(:text) { 'new content' }
    let(:raw_post) { params.to_json }

    example_request 'Update snippet' do
      explanation 'Update snippet with new content'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq('about')
      expect(Snippet.find_by_slug(:about).text).to eq('new content')
    end
  end

  put '/api/v1/snippets/:id' do
    let(:snippet) { snippets.first }
    let(:id) { snippet.id }
    parameter :slug, 'Slug'
    parameter :text, 'Text'

    let(:slug) { '%%^^##' }
    let(:text) { 'new content' }
    let(:raw_post) { params.to_json }

    example_request 'Update page' do
      explanation 'Update page with new content'

      expect(status).to eq 422
      expect(JSON.parse(response_body)['slug']).not_to eq('%%^^##')
    end
  end

  delete '/api/v1/snippets/:id' do
    let(:snippet) { snippets.first }
    let(:id) { snippet.id }
    example_request 'Delete snippet' do
      explanation 'Deletes snippet and returns status 204'

      expect(status).to eq 204
      expect(Snippet.find_by_id(snippet.id)).to be_nil
    end
  end
end
