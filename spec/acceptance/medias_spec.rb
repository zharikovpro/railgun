require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

# https://github.com/thoughtbot/factory_girl/issues/385#issuecomment-5876695
include ActionDispatch::TestProcess

RSpec.resource 'Medias', issues: [132] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:editor).api_token}" }
  let!(:medias) { create_list(:media, 2) }
  response_field :id, 'media ID', 'Type' => 'Integer'
  response_field :slug, 'Name of media', 'Type' => 'String'
  response_field :file, 'Path to media file', 'Type' => 'Text'

  get '/api/v1/medias' do
    example_request 'List medias' do
      explanation 'List all available medias'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq 2
    end
  end

  get '/api/v1/medias/-1' do
    example_request 'resource not found' do
      explanation 'returns status 404'

      expect(status).to eq 404
    end
  end

  get '/api/v1/medias/:id' do
    let(:media) { medias.first }
    let(:id) { media.id }

    example_request 'Get specific media' do
      explanation 'Get a media by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq media.slug
    end
  end

  post '/api/v1/medias' do
    let(:file) { fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg') }
    parameter :slug, 'Slug', required: true, scope: :media
    parameter :file, 'File', required: true, scope: :media
    example_request 'Create media' do
      explanation 'Create the new media'
      do_request(slug: 'avatar', file: file)

      expect(status).to eq 201
      expect(JSON.parse(response_body)['slug']).to eq('avatar')
      expect(Media.find_by_slug(:avatar).file_file_name).to eq('demo.jpg')
    end
  end

  put '/api/v1/medias/:id' do
    let(:media) { medias.first }
    let(:id) { media.id }
    let(:file) { fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg') }
    parameter :slug, 'Slug', required: true, scope: :media
    parameter :file, 'File', required: true, scope: :media
    example_request 'Update media' do
      explanation 'Update media with new path to media content'
      do_request(slug: 'about', file: file)

      expect(status).to eq 200
      expect(JSON.parse(response_body)['slug']).to eq('about')
      expect(Media.find_by_slug(:about).file_file_name).to eq('demo.jpg')
    end
  end

  put '/api/v1/medias/:id' do
    let(:media) { medias.first }
    let(:id) { media.id }
    let(:file) { fixture_file_upload(Rails.root + 'spec/fixtures/files/images/demo.jpg') }
    parameter :slug, 'Slug', required: true, scope: :media
    parameter :file, 'File', required: true, scope: :media

    example_request 'Update media' do
      explanation 'Update media with new content'
      do_request(slug: '%%^^##', file: file)

      expect(status).to eq 422
      expect(JSON.parse(response_body)['slug']).not_to eq('%%^^##')
    end
  end

  delete '/api/v1/medias/:id' do
    let(:media) { medias.first }
    let(:id) { media.id }
    example_request 'Delete media' do
      explanation 'Deletes media and returns status 204'

      expect(status).to eq 204
      expect(Media.find_by_id(media.id)).to be_nil
    end
  end
end
