require 'rails_helper'

RSpec.describe '/api/v1/snippets', type: :request, issues: [116] do
  let!(:snippets) { create_list(:snippet, 10) }
  let(:snippet_id) { snippets.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:developer).api_token}" }
  }

=begin
  describe 'GET /' do
    it 'returns snippets' do
      get '/api/v1/snippets', headers: authenticated_header

      expect(response.parsed_body.size).to eq(10)
    end
  end
=end

  describe 'POST' do
    context 'when request is valid' do
      before { post '/api/v1/snippets', headers: authenticated_header, params: { slug: 'faq', text: 'something' } }

      it 'creates a snippet' do
        expect(response.parsed_body['slug']).to eq('faq')
        expect(Snippet.find_by_slug(:faq).text).to eq('something')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/snippets', headers: authenticated_header, params: { slug: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /:id' do
    it 'updates the record' do
      put "/api/v1/snippets/#{snippet_id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Snippet.find_by_id(snippet_id).slug).to eq('about_1')
    end

    context 'when format is not correct' do
      before { put "/api/v1/snippets/#{snippet_id}", headers: authenticated_header, params: { slug: '%%^^##' } }

      it 'updates the record' do
        expect(Snippet.find_by_id(snippet_id).slug).not_to eq('%%^^##')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
