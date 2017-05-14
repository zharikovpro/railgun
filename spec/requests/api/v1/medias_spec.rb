require 'rails_helper'

RSpec.describe '/api/v1/medias', type: :request, issues: [116] do
  let!(:medias) { create_list(:media, 10) }
  let(:media_id) { medias.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'GET /' do
    context 'authentication ok' do
      it 'returns medias' do
        get '/api/v1/medias', headers: authenticated_header

        expect(response.parsed_body.size).to eq(10)
      end
    end
  end

  describe 'GET /:id' do
    context 'when the record exists' do
      it 'returns the media' do
        get "/api/v1/medias/#{media_id}", headers: authenticated_header

        expect(response.parsed_body['id']).to eq(media_id)
      end
    end
  end

  describe 'POST /' do
    context 'when request is valid' do
      before :each do
        @file = fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg')
      end

      before { post '/api/v1/medias', headers: authenticated_header, params: { slug: 'faq', file: @file } }

      it 'creates a media' do
        expect(response.parsed_body['slug']).to eq('faq')
        expect(Media.find_by_slug(:faq).file_file_name).to eq('demo.jpg')
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
      it 'updates the record' do
        put "/api/v1/medias/#{media_id}", headers: authenticated_header, params: { slug: 'about_1' }

        expect(Media.find_by_id(media_id).slug).to eq('about_1')
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
  end

  describe 'DELETE /:id' do
    it 'returns status code 204' do
      delete "/api/v1/medias/#{media_id}", headers: authenticated_header

      expect(Media.find_by_id(media_id)).to be_nil
      expect(response).to have_http_status(204)
    end
  end
end
