require 'rails_helper'

RSpec.describe '/api/v1/pages', type: :request, issues: [116] do
  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'GET /' do
    it 'returns pages' do
      get '/api/v1/pages', headers: authenticated_header

      expect(response.parsed_body.size).to eq(10)
    end
  end

  describe 'GET /:id' do
    it 'returns the page' do
      get "/api/v1/pages/#{page_id}", headers: authenticated_header

      expect(response.parsed_body['id']).to eq(page_id)
    end
  end

  describe 'POST /' do
    context 'when request is valid' do
      before { post '/api/v1/pages', headers: authenticated_header, params: { slug: 'faq', markdown: 'something' } }

      it 'creates a page' do
        expect(response.parsed_body['slug']).to eq('faq')
        expect(Page.find_by_slug(:faq).markdown).to eq('something')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/pages', headers: authenticated_header, params: { slug: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /:id' do
    it 'updates page' do
      put "/api/v1/pages/#{page_id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Page.find_by_id(page_id).slug).to eq('about_1')
    end

    context 'when format is not correct' do
      before { put "/api/v1/pages/#{page_id}", headers: authenticated_header, params: { slug: '%%^^##' } }

      it 'updates the record' do
        expect(Page.find_by_id(page_id).slug).not_to eq('%%^^##')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /:id' do
    it 'deletes page' do
      delete "/api/v1/pages/#{page_id}", headers: authenticated_header

      expect(Page.find_by_id(page_id)).to be_nil
    end
  end
end
