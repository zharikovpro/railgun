require 'rails_helper'

RSpec.describe '/api/v1/pages', type: :request, issues: [116] do
  let!(:page) { create(:page) }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  describe 'POST /' do
    it 'creates a page' do
      post '/api/v1/pages', headers: authenticated_header, params: { slug: 'faq', markdown: 'something' }

      expect(response.parsed_body['slug']).to eq('faq')
      expect(Page.find_by_slug(:faq).markdown).to eq('something')
    end
  end

  describe 'PUT /:id' do
    it 'when format is correct - updates page' do
      put "/api/v1/pages/#{page.id}", headers: authenticated_header, params: { slug: 'about_1' }

      expect(Page.find_by_id(page.id).slug).to eq('about_1')
    end

    it 'slug can not contain special chars' do
      put "/api/v1/pages/#{page.id}", headers: authenticated_header, params: { slug: '%%^^##' }

      expect(response).to have_http_status(422)
    end
  end
end
