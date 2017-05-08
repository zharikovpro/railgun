require 'rails_helper'

RSpec.describe 'snippets API', type: :request, issues: [116] do
  let!(:snippets) { create_list(:snippet, 10) }
  let(:snippet_id) { snippets.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:developer).api_token}" }
  }

  describe 'GET /api/v1/snippets' do
    context 'authentication error' do
      it 'returns status code 401' do
        get '/api/v1/snippets'
        expect(response).to have_http_status(401)
      end
    end

    context 'authentication ok' do
      before { get '/api/v1/snippets', headers: authenticated_header }

      it 'returns snippets' do
        expect(response.parsed_body.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/snippets/:id' do
    before { get "/api/v1/snippets/#{snippet_id}", headers: authenticated_header }

    context 'when the record exists' do
      it 'returns the snippet' do
        expect(response.parsed_body['id']).to eq(snippet_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'returns status code 404' do
        get '/api/v1/snippets/0', headers: authenticated_header
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/snippets' do
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

  describe 'PUT /api/v1/snippets/:id' do
    context 'when the record exists and format is correct' do
      before { put "/api/v1/snippets/#{snippet_id}", headers: authenticated_header, params: { slug: 'about_1' } }

      it 'updates the record' do
        expect(Snippet.find_by_id(snippet_id).slug).to eq('about_1')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
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

  describe 'DELETE /api/v1/snippets/:id' do
    it 'returns status code 200' do
      delete "/api/v1/snippets/#{snippet_id}", headers: authenticated_header

      expect(Snippet.find_by_id(snippet_id)).to be_nil
      expect(response).to have_http_status(200)
    end
  end
end
