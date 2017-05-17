require 'rails_helper'

RSpec.describe '/api/v1/medias', issues: [134] do
  let!(:media) { create(:media) }
  let(:authenticated_header) { create(:editor).api_header }

  describe 'POST /' do
    it 'creates a media' do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg')
      post '/api/v1/medias', headers: authenticated_header, params: { slug: 'faq', file: @file }

      expect(response.parsed_body['slug']).to eq('faq')
      expect(Media.find_by_slug(:faq).file_file_name).to eq('demo.jpg')
    end
  end

  describe 'PUT /:id' do
    it 'updates media with valid slug' do
      put "/api/v1/medias/#{media.id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Media.find_by_id(media.id).slug).to eq('about_1')
    end

    it 'slug cannot contain special chars' do
      put "/api/v1/medias/#{media.id}", headers: authenticated_header, params: { slug: '%%^^##' }

      expect(response).to have_http_status(422)
    end
  end
end
