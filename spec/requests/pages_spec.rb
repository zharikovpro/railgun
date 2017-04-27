require 'rails_helper'

RSpec.describe 'pages API', type: :request, issues: [116] do
  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }

  describe 'GET /api/pages' do
    before { get '/api/pages' }

    it 'returns pages' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/pages/:id' do
    before { get "/api/pages/#{page_id}" }

    context 'when the record exists' do
      it 'returns the page' do
        expect(json['id']).to eq(page_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:page_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find page/)
      end
    end
  end

  describe 'POST /pages' do
    let(:valid_attributes) { { slug: 'faq' } }

    context 'when request is valid' do
      before { post '/pages', params: valid_attributes }

      it 'creates a page' do
        expect(json['slug']).to eq('faq')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/pages', params: { slug: 'faq' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /pages/:id' do
    let(:valid_attributes) { { id: 'faq' }.to_json }

    context 'when the record exists' do
      before { put "/pages/#{page_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /pages/:id' do
    before { delete "/pages/#{page_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
