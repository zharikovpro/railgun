require 'rails_helper'

RSpec.describe API::GraphqlController, issues: ['railgun#147'] do
  context 'Developer can see snippets' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:developer).api_token}" }
    }

    describe 'post /api/graphql#execute' do
      it 'valid request returns snippets' do
        snippets = create_list(:snippet, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ snippets { slug }}" }

        expect(response.body).to match(snippets.first.slug)
      end

      it 'valid request returns snippets' do
        snippet = create(:snippet)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ snippet(slug: \"#{snippet.slug}\") { slug text }}" }

        expect(response.body).to match(snippet.text)
      end
    end
  end

  context 'Editor can see medias and pages' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:editor).api_token}" }
    }

    describe 'post /api/graphql#execute' do
      it 'valid request returns medias' do
        medias = create_list(:media, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ medias { slug file_file_name }}" }

        expect(response.body).to match(medias.first.slug)
      end

      it 'valid request returns media' do
        media = create(:media)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ media(slug: \"#{media.slug}\") { slug file_file_name }}" }

        expect(response.body).to match(media.file_file_name)
      end

      it 'valid request returns pages' do
        pages = create_list(:page, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ pages { slug markdown }}" }

        expect(response.body).to match(pages.first.slug)
      end

      it 'valid request returns page' do
        page = create(:page)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ page(slug: \"#{page.slug}\") { slug markdown }}" }

        expect(response.body).to match(page.markdown)
      end
    end
  end

  context 'Administrator can see users and user_roles' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:administrator).api_token}" }
    }

    describe 'post /api/graphql#execute' do
      it 'valid request returns users' do
        users = create_list(:user, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ users { id email }}" }

        expect(response.body).to match(users.first.email)
      end

      it 'valid request returns user' do
        user = create(:user)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ user(id: \"#{user.id}\") { id email }}" }

        expect(response.body).to match(user.email)
      end

      it 'valid request returns user_roles' do
        user = create(:owner)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ user_role(user_id: #{user.id}) { roles }}" }

        expect(response.body).to match('owner')
      end
    end
  end
end
