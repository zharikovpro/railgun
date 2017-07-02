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
    let(:user) { create(:user) }

    describe 'queries users, user_roles' do
      it 'list of users id and email' do
        create(:user)
        expect(data('{ users { id email }}')['users'].size).to eq(2)
      end

      it 'user email by param id' do
        expect(data("{ user(id: \"#{user.id}\") { id email }}")['user']['email']).to eq(user.email)
      end

      it 'Create User' do
        expect(data("mutation{addUser(user: {email: \"test@mail.com\", password: \"qwerty\", password_confirmation: \"qwerty\"}) { id email }}")['addUser']['email']).to eq('test@mail.com')
        expect(User.find_by_email('test@mail.com').email).to eq('test@mail.com')
        expect(User.find_by_email('test@mail.com').valid_password?('qwerty')).to be_truthy
      end

      it 'Update user by ID' do
        expect(data("mutation{updateUser(id: \"#{user.id}\", user: {email: \"new@mail.com\", password: \"updated_password\", password_confirmation: \"updated_password\"}) {id email}}")['updateUser']['email']).to eq('new@mail.com')
        expect(User.find(user.id).email).to eq('new@mail.com')
        expect(User.find(user.id).valid_password?('updated_password')).to be_truthy
      end

      it 'Delete user by ID' do
        expect(data("mutation{deleteUser(id: \"#{user.id}\") {id email}}")['deleteUser']['email']).to eq(user.email)
        expect(User.find_by_id(user.id)).to be_nil
      end

      it 'user roles by param id' do
        owner = create(:owner)

        expect(data("{ user_roles(user_id: #{owner.id}) { roles }}")['user_roles']['roles']).to eq("#{owner.roles}")
      end

      it 'Add user role by user ID' do
        expect(data("mutation{addUserRole(user_id: \"#{user.id}\", user_role: {roles: \"editor\"}) { roles }}")['addUserRole']['roles']).to eq("#{[:editor]}")
        expect(User.find(user.id).roles).to include(:editor)
      end

      it 'Delete user_role by user ID' do
        user.add_role(:developer)
        expect(data("mutation{deleteUserRole(user_id: \"#{user.id}\", user_role: {roles: \"developer\"}) { roles }}")['deleteUserRole']['roles']).to eq("#{user.roles}")
        expect(User.find(user.id).roles).not_to include(:developer)
      end
    end
  end

  context 'Developer can use snippets' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:developer).api_token}" }
    }

    describe 'queries snippets' do
      let(:snippet) { create(:snippet) }

      it 'list of snippets slug and text' do
        create_list(:snippet, 2)

        expect(data('{ snippets { slug text }}')['snippets'].size).to eq(2)
      end

      it 'snippet by param slug' do
        expect(data("{ snippet(slug: \"#{snippet.slug}\") { slug text }}")['snippet']['text']).to eq(snippet.text)
      end

      it 'Create Snippet' do
        expect(data("mutation{addSnippet(snippet: {slug: \"script\", text: \"My graphql snippet\"}) { slug text }}")['addSnippet']['slug']).to eq('script')
        expect(Snippet.find_by_slug('script').text).to eq('My graphql snippet')
      end

      it 'Update snippet by param slug' do
        expect(data("mutation{updateSnippet(slug: \"#{snippet.slug}\", snippet: {slug: \"updated\", text: \"new snippet\"}) {slug text}}")['updateSnippet']['text']).to eq('new snippet')
        expect(Snippet.find_by_slug('updated').text).to eq('new snippet')
      end

      it 'Delete snippet by param slug' do
        expect(data("mutation{deleteSnippet(slug: \"#{snippet.slug}\") {slug text}}")['deleteSnippet']['slug']).to eq(snippet.slug)
        expect(Snippet.find_by_id(snippet.id)).to be_nil
      end
    end
  end

  context 'Editor can use medias and pages' do
    let(:authenticated_header) {
      { 'Authorization' => "Bearer #{create(:editor).api_token}" }
    }

    describe 'queries medias' do
      let(:media) { create(:media) }

      it 'list of medias slug and file name' do
        create_list(:media, 2)

        expect(data('{ medias { slug file_file_name }}')['medias'].size).to eq(2)
      end

      it 'media by param slug' do
        expect(data("{ media(slug: \"#{media.slug}\") { slug file_file_name }}")['media']['file_file_name']).to eq(media.file_file_name)
      end

      it 'Create Media' do
        expect(data("mutation{addMedia(media: {slug: \"file\", file_file_name: \"#{fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg')}\"}) { slug file_file_name }}")['addMedia']['slug']).to eq('file')
        expect(Media.find_by_slug(:file).file_file_name).not_to be_nil
      end

      it 'Update media by param slug' do
        expect(data("mutation{updateMedia(slug: \"#{media.slug}\", media: {slug: \"updated\", file_file_name: \"#{fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg')}\"}) {slug file_file_name}}")['updateMedia']['slug']).to eq('updated')
        expect(Media.find_by_slug(:updated).file_file_name).not_to be_nil
      end

      it 'Delete media by param slug' do
        expect(data("mutation{deleteMedia(slug: \"#{media.slug}\") {slug file_file_name}}")['deleteMedia']['slug']).to eq(media.slug)
        expect(Media.find_by_id(media.id)).to be_nil
      end
    end

    describe 'queries pages' do
      let(:page) { create(:page) }

      it 'list of pages slug and markdown' do
        create_list(:page, 2)

        expect(data('{ pages { slug markdown }}')['pages'].size).to eq(2)
      end

      it 'page by param slug' do
        expect(data("{ page(slug: \"#{page.slug}\") { slug markdown }}")['page']['markdown']).to eq(page.markdown)
      end

      it 'Create Page' do
        expect(data("mutation{addPage(page: {slug: \"faq\", markdown: \"some text\"}) { slug markdown }}")['addPage']['slug']).to eq('faq')
        expect(Page.find_by_slug('faq').markdown).to eq('some text')
      end

      it 'Update page by param slug' do
        expect(data("mutation{updatePage(slug: \"#{page.slug}\", page: {slug: \"updated\", markdown: \"new markdown\"}) {slug markdown}}")['updatePage']['markdown']).to eq('new markdown')
        expect(Page.find_by_slug('updated').markdown).to eq('new markdown')
      end

      it 'Delete page by param slug' do
        expect(data("mutation{deletePage(slug: \"#{page.slug}\") {slug markdown}}")['deletePage']['slug']).to eq(page.slug)
        expect(Page.find_by_id(page.id)).to be_nil
      end
    end
  end
end
