require 'rails_helper'

RSpec.describe API::GraphqlController, issues: ['railgun#147'] do

  context 'Administrator can use users and user_roles' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:administrator).api_token}" }
    }

    describe 'queries users, user_roles' do
      it 'list of users id and email' do
        users = create_list(:user, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: '{ users { id email }}' }

        expect(response.body).to match(users.first.email)
      end

      it 'user email by param id' do
        user = create(:user)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ user(id: \"#{user.id}\") { id email }}" }

        expect(response.body).to match(user.email)
      end

      it 'user roles by param id' do
        user = create(:owner)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ user_roles(user_id: #{user.id}) { roles }}" }

        expect(response.body).to match('owner')
      end
    end
  end

  context 'Developer can use snippets' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:developer).api_token}" }
    }

    describe 'queries snippets' do
      it 'list of snippets slug and text' do
        snippets = create_list(:snippet, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: '{ snippets { slug text }}' }

        expect(response.body).to match(snippets.first.slug)
      end

      it 'snippet by param slug' do
        snippet = create(:snippet)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ snippet(slug: \"#{snippet.slug}\") { slug text }}" }

        expect(response.body).to match(snippet.text)
      end

      it 'Create Snippet' do
        post '/api/graphql', headers: authenticated_header, params: { query: "mutation{addSnippet(snippet: {slug: \"qwe2\", text: \"My graphql snippet\"}) { slug text }}" }

        expect(Snippet.find_by_slug('qwe2').text).to eq('My graphql snippet')
      end
    end
  end

  context 'Editor can use medias and pages' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:editor).api_token}" }
    }

    describe 'queries medias' do
      it 'list of medias slug and file name' do
        medias = create_list(:media, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: '{ medias { slug file_file_name }}' }

        expect(response.body).to match(medias.first.slug)
      end

      it 'media by param slug' do
        media = create(:media)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ media(slug: \"#{media.slug}\") { slug file_file_name }}" }

        expect(response.body).to match(media.file_file_name)
      end

      # TODO adding a real file
      it 'Create Media' do
        post '/api/graphql', headers: authenticated_header, params: { query: "mutation{addMedia(media: {slug: \"file\", file_file_name: \"Path_to_file\"}) { slug file_file_name }}" }

        expect(Media.find_by_slug('file').file_file_name).to eq('Path_to_file')
      end
    end

    describe 'queries pages' do
      it 'list of pages slug and markdown' do
        pages = create_list(:page, 2)
        post '/api/graphql', headers: authenticated_header, params: { query: '{ pages { slug markdown }}' }

        expect(response.body).to match(pages.first.slug)
      end

      it 'page by param slug' do
        page = create(:page)
        post '/api/graphql', headers: authenticated_header, params: { query: "{ page(slug: \"#{page.slug}\") { slug markdown }}" }

        expect(response.body).to match(page.markdown)
      end

      it 'Create Page' do
        post '/api/graphql', headers: authenticated_header, params: { query: "mutation{addPage(page: {slug: \"faq\", markdown: \"some text\"}) { slug markdown }}" }

        expect(Page.find_by_slug('faq').markdown).to eq('some text')
      end
    end
  end
end
