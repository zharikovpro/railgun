require 'rails_helper'

RSpec.describe 'pages API', type: :request, issues: [116] do
  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }
  let(:authenticated_header) {
    token = Knock::AuthToken.new(payload: { sub: create(:editor).id }).token
    { 'Authorization': "Bearer #{token}" }
  }

  describe 'GET /api/v1/pages' do
    context 'when authenticates is not correctly' do
      before { get '/api/v1/pages' }

      it 'returns pages' do
        expect(response.body).to match(/Not Authorized/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when authenticates correctly' do
      before { get '/api/v1/pages', headers: authenticated_header }

      it 'returns pages' do
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/pages/:id' do
    before { get "/api/v1/pages/#{page_id}", headers: authenticated_header }

    context 'when the record exists' do
      it 'returns the page' do
        expect(json['id']).to eq(page_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:page_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find page/)
      end
    end
  end

  describe 'POST /api/v1/pages' do

    context 'when request is valid' do
      before { post '/api/v1/pages', headers: authenticated_header, params: { slug: 'faq', markdown: 'something' } }

      it 'creates a page' do
        expect(json['slug']).to eq('faq')
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
        expect(response.body).to  match(/can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/pages/:id' do

    context 'when the record exists and format is correct' do
      before { put "/api/v1/pages/#{page_id}", headers: authenticated_header, params: { slug: 'about_1' } }

      it 'updates the record' do
        expect(Page.find_by_id(page_id).slug).to eq('about_1')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(202)
      end
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

  describe 'DELETE /api/v1/pages/:id' do

    it 'returns status code 200' do
      delete "/api/v1/pages/#{page_id}", headers: authenticated_header

      expect(Page.find_by_id(page_id)).to be_nil
      expect(response).to have_http_status(202)
    end
  end
end
