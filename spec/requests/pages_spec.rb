require 'rails_helper'

RSpec.describe 'pages API', type: :request, issues: [116] do
  let!(:pages) { create_list(:page, 10) }
  let(:page_slug) { pages.first.slug }

  describe 'GET /pages' do
    before { get '/pages' }

    it 'returns pages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pages/:slug' do
    before { get "/pages/#{page_slug}" }

    context 'when the record exists' do
      it 'returns the page' do
        expect(json).not_to be_empty
        expect(json['slug']).to eq(page_slug)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:page_slug) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find page/)
      end
    end
  end

  describe 'POST /pages' do
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when request is valid' do
      before { post '/pages', params: valid_attributes }

      it 'creates a page' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/pages', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /pages/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/pages/#{page_slug}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /pages/:id' do
    before { delete "/pages/#{page_slug}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
