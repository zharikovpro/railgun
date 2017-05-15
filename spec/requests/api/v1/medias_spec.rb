require 'rails_helper'

RSpec.describe '/api/v1/medias', type: :request, issues: [116] do
  let!(:media) { create(:media) }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'POST /' do
    it 'creates a media' do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg')
      post '/api/v1/medias', headers: authenticated_header, params: { slug: 'faq', file: @file }

      expect(response.parsed_body['slug']).to eq('faq')
      expect(Media.find_by_slug(:faq).file_file_name).to eq('demo.jpg')
    end
  end
# file can be blank!
  describe 'PUT /:id' do
    it 'when format is correct updates media' do
      put "/api/v1/medias/#{media.id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Media.find_by_id(media.id).slug).to eq('about_1')
    end

    it 'when format is not correct' do
      put "/api/v1/medias/#{media.id}", headers: authenticated_header, params: { slug: '%%^^##' }

      expect(Media.find_by_id(media.id).slug).not_to eq('%%^^##')
      expect(response).to have_http_status(422)
    end
  end
end
