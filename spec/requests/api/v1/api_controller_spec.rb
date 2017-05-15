require 'rails_helper'

module Api
  module V1
    class ResourcesController < Api::V1::ApiController
    end
  end
end

class Resource < ApplicationRecord
  validates_presence_of :content
end

class ResourcePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      [1, 2, 3]
    end
  end

  def show?
    true
  end

  alias_method :index?, :show?
  alias_method :create?, :show?
  alias_method :update?, :show?
  alias_method :destroy?, :show?

  def permitted_attributes
    [:content]
  end
end

RSpec.describe Api::V1::ResourcesController, issues: [133] do
  before do
    Rails.application.routes.draw do
      namespace :api do
        namespace :v1 do
          resources :resources
        end
      end
    end
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :resources do |t|
      t.string :content
    end
  end

  after do
    Rails.application.reload_routes!
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :resources
  end

  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:owner).api_token}" }
  }
  let(:resource) { Resource.create!(content: 'something') }

  context 'when record does not exist' do
    it 'returns status code 404' do
      get '/api/v1/resources/-1', headers: authenticated_header
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /' do
    context 'authentication error' do
      it 'returns status code 401' do
        get '/api/v1/resources'

        expect(response).to have_http_status(401)
      end
    end

    context 'authentication ok' do
      before { get '/api/v1/resources', headers: authenticated_header }
      it 'returns resources' do
        expect(response.parsed_body.size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /:id' do
    context 'when the record exists' do
      it 'returns resource' do
        get "/api/v1/resources/#{resource.id}", headers: authenticated_header
        expect(response.parsed_body['id']).to eq(1)
      end

      it 'returns status code 200' do
        get "/api/v1/resources/#{resource.id}", headers: authenticated_header
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST#create' do

    it 'when request is valid returns status code 201' do
      post '/api/v1/resources', headers: authenticated_header, params: { content: 'Foobar' }
      expect(response).to have_http_status(201)
    end

    context 'when request is invalid' do
      before { post '/api/v1/resources', headers: authenticated_header }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /:id' do
    context 'when request is invalid' do
      before { put "/api/v1/resources/#{resource.id}", headers: authenticated_header, params: { content: ''} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    it 'returns status code 404 if not found' do
      put '/api/v1/resources/-1', headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end

  describe 'DELETE /:id' do
    context 'deletes resource' do
      before { delete "/api/v1/resources/#{resource.id}", headers: authenticated_header }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'delete resource' do
        expect(Resource.find_by_id(resource.id)).to be_nil
      end
    end

    it 'returns status code 404 if not found' do
      delete '/api/v1/resources/-1', headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
