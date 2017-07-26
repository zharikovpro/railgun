require 'rails_helper'

module API
  module V1
    class ResourcesController < API::V1::ApiController
    end
  end
end

class Resource < ApplicationRecord
  validates_presence_of :content
end

class ResourcePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
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

RSpec.describe API::V1::ResourcesController, issues: ['railgun#133'] do
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

  let(:authenticated_header) do
    { 'Authorization' => "Bearer #{create(:user).api_token}" }
  end
  let(:resource) { Resource.create!(content: 'something') }

  context 'unauthenticated user' do
    it 'GET resources returns status 401' do
      get '/api/v1/resources'

      expect(response).to have_http_status(401)
    end

    %w(get put delete).each do |method|
      it "#{method.to_s.upcase} resource returns status 401" do
        public_send(method, '/api/v1/resources/1')

        expect(response).to have_http_status(401)
      end
    end
  end

  context 'resource not found' do
    %w(get put delete).each do |method|
      it "#{method.to_s.upcase} returns status 404" do
        public_send(method, '/api/v1/resources/-1', headers: authenticated_header)

        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /' do
    let!(:resources) { 3.times { Resource.create!(content: 'test') } }
    before { get '/api/v1/resources', headers: authenticated_header }

    it 'returns resources' do
      expect(response.parsed_body.size).to eq(3)
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /:id' do
    before { get "/api/v1/resources/#{resource.id}", headers: authenticated_header }

    it 'returns resource' do
      expect(response.parsed_body['id']).to eq(1)
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST#create' do
    it 'valid request returns status 201' do
      post '/api/v1/resources', headers: authenticated_header, params: { content: 'Foobar' }

      expect(response).to have_http_status(201)
    end

    context 'when request is invalid returns status 422' do
      before { post '/api/v1/resources', headers: authenticated_header }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /:id' do
    it 'invalid request returns status 422' do
      put "/api/v1/resources/#{resource.id}", headers: authenticated_header, params: { content: '' }

      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE /:id' do
    before { delete "/api/v1/resources/#{resource.id}", headers: authenticated_header }

    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end

    it 'deletes resource' do
      expect(Resource.find_by_id(resource.id)).to be_nil
    end
  end
end
