require 'rails_helper'

RSpec.describe '/api/v1/medias', type: :request, issues: [116] do
  let!(:medias) { create_list(:media, 10) }
  let(:media_id) { medias.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'GET /' do
    context 'authentication error' do
      it 'returns status code 401' do
        get '/api/v1/medias'
        expect(response).to have_http_status(401)
      end
    end

    context 'authentication ok' do
      before { get '/api/v1/medias', headers: authenticated_header }

      it 'returns medias' do
        expect(response.parsed_body.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /:id' do
    before { get "/api/v1/medias/#{media_id}", headers: authenticated_header }

    context 'when the record exists' do
      it 'returns the media' do
        expect(response.parsed_body['id']).to eq(media_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'returns status code 404' do
        get '/api/v1/medias/-1', headers: authenticated_header
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /' do
    fcontext 'when request is valid' do
      before { post '/api/v1/medias', headers: authenticated_header, params: { slug: 'faq', file: Rails.root + 'spec/media/images/demo.jpg' } }

      it 'creates a media' do
        expect(response.parsed_body['slug']).to eq('faq')
        expect(Media.find_by_slug(:faq).file_file_name).to eq('something.jpg')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/medias', headers: authenticated_header, params: { slug: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /:id' do
    context 'when the record exists and format is correct' do
      before { put "/api/v1/medias/#{media_id}", headers: authenticated_header, params: { slug: 'about_1' } }

      it 'updates the record' do
        expect(Media.find_by_id(media_id).slug).to eq('about_1')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when format is not correct' do
      before { put "/api/v1/medias/#{media_id}", headers: authenticated_header, params: { slug: '%%^^##' } }

      it 'updates the record' do
        expect(Media.find_by_id(media_id).slug).not_to eq('%%^^##')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    it 'returns status code 404 if not found' do
      put "/api/v1/medias/-1", headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end

  describe 'DELETE /:id' do
    it 'returns status code 204' do
      delete "/api/v1/medias/#{media_id}", headers: authenticated_header

      expect(Media.find_by_id(media_id)).to be_nil
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404 if not found' do
      delete "/api/v1/medias/-1", headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
