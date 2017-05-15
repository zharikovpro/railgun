require 'rails_helper'

RSpec.describe '/api/v1/snippets', type: :request, issues: [116] do
  let!(:snippet) { create(:snippet) }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:developer).api_token}" }
  }

  describe 'POST /' do
    it 'creates a snippet' do
      post '/api/v1/snippets', headers: authenticated_header, params: { slug: 'faq', text: 'something' }

      expect(response.parsed_body['slug']).to eq('faq')
      expect(Snippet.find_by_slug(:faq).text).to eq('something')
    end
  end

  describe 'PUT /:id' do
    it 'when format is correct - updates snippet' do
      put "/api/v1/snippets/#{snippet.id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Snippet.find_by_id(snippet.id).slug).to eq('about_1')
    end

    it 'slug can not contain special chars' do
      put "/api/v1/snippets/#{snippet.id}", headers: authenticated_header, params: { slug: '%%^^##' }

      expect(response).to have_http_status(422)
    end
  end
end
