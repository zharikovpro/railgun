require 'rails_helper'

RSpec.describe API::GraphqlController, issues: ['railgun#147'] do

  def data(query)
    post '/api/graphql', headers: authenticated_header, params: { query: query }
    response.parsed_body['data']
  end

  context 'Administrator can use users and user_roles' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:administrator).api_token}" }
    }

    describe 'queries users, user_roles' do
      it 'list of users id and email' do
        create(:user)
        expect(data('{ users { id email }}')['users'].size).to eq(2)
      end

      it 'user email by param id' do
        user = create(:user)

        expect(data("{ user(id: \"#{user.id}\") { id email }}")['user']['email']).to eq(user.email)
      end

      it 'user roles by param id' do
        owner = create(:owner)

        expect(data("{ user_roles(user_id: #{owner.id}) { roles }}")['user_roles']['roles']).to eq("#{owner.roles}")
      end
    end
  end

  context 'Developer can use snippets' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:developer).api_token}" }
    }

    describe 'queries snippets' do
      it 'list of snippets slug and text' do
        create_list(:snippet, 2)

        expect(data('{ snippets { slug text }}')['snippets'].size).to eq(2)
      end

      it 'snippet by param slug' do
        snippet = create(:snippet)

        expect(data("{ snippet(slug: \"#{snippet.slug}\") { slug text }}")['snippet']['text']).to eq(snippet.text)
      end

      it 'Create Snippet' do
        expect(data("mutation{addSnippet(snippet: {slug: \"script\", text: \"My graphql snippet\"}) { slug text }}")['addSnippet']['slug']).to eq('script')
        expect(Snippet.find_by_slug('script').text).to eq('My graphql snippet')
      end

      it 'Delete snippet by param slug' do
        snippet = create(:snippet)

        expect(data("mutation{deleteSnippet(slug: \"#{snippet.slug}\") {slug}}")['deleteSnippet']['slug']).to eq(snippet.slug)
        expect(Snippet.find_by_id(snippet.id)).to be_nil
      end
    end
  end

  context 'Editor can use medias and pages' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:editor).api_token}" }
    }

    describe 'queries medias' do
      it 'list of medias slug and file name' do
        create_list(:media, 2)

        expect(data('{ medias { slug file_file_name }}')['medias'].size).to eq(2)
      end

      it 'media by param slug' do
        media = create(:media)

        expect(data("{ media(slug: \"#{media.slug}\") { slug file_file_name }}")['media']['file_file_name']).to eq(media.file_file_name)
      end

      # TODO adding a real file
      it 'Create Media' do
        expect(data("mutation{addMedia(media: {slug: \"file\", file_file_name: \"Path_to_file\"}) { slug file_file_name }}")['addMedia']['slug']).to eq('file')
        expect(Media.find_by_slug('file').file_file_name).to eq('Path_to_file')
      end

      it 'Delete media by param slug' do
        media = create(:media)

        expect(data("mutation{deleteMedia(slug: \"#{media.slug}\") {slug}}")['deleteMedia']['slug']).to eq(media.slug)
        expect(Media.find_by_id(media.id)).to be_nil
      end
    end

    describe 'queries pages' do
      it 'list of pages slug and markdown' do
        create_list(:page, 2)

        expect(data('{ pages { slug markdown }}')['pages'].size).to eq(2)
      end

      it 'page by param slug' do
        page = create(:page)

        expect(data("{ page(slug: \"#{page.slug}\") { slug markdown }}")['page']['markdown']).to eq(page.markdown)
      end

      it 'Create Page' do
        expect(data("mutation{addPage(page: {slug: \"faq\", markdown: \"some text\"}) { slug markdown }}")['addPage']['slug']).to eq('faq')
        expect(Page.find_by_slug('faq').markdown).to eq('some text')
      end

      it 'Update page by param slug' do
        page = create(:page)

        expect(data("{ page(slug: \"#{page.slug}\") { slug markdown }}")['page']['markdown']).to eq(page.markdown)
      end

      it 'Delete page by param slug' do
        page = create(:page)

        expect(data("mutation{deletePage(slug: \"#{page.slug}\") {slug}}")['deletePage']['slug']).to eq(page.slug)
        expect(Page.find_by_id(page.id)).to be_nil
      end
    end
  end
end
