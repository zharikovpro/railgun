require 'rails_helper'

module Api
  module V1
    class ResourcesController < Api::V1::ApiController
    end
  end
end

class Resource
end

class ResourcePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      []
    end
  end

  def show?
    true
  end

  alias_method :index?, :show?
  alias_method :create?, :show?
  alias_method :update?, :show?
  alias_method :destroy?, :show?
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
  end

  after do
    Rails.application.reload_routes!
  end

  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  fdescribe 'GET /' do
    context 'authentication error' do
      it 'returns status code 401' do
        get '/api/v1/resources'
        expect(response).to have_http_status(401)
      end
    end

    context 'authentication ok' do
      it 'returns pages' do
        #mock_model('Resource')
        get '/api/v1/resources', headers: authenticated_header
        expect(response.parsed_body.size).to eq(0)
      end

      it 'returns status code 200' do
        #mock_model('Resource')
        get '/api/v1/resources', headers: authenticated_header
        expect(response).to have_http_status(200)
      end
    end
  end

  xdescribe 'GET /:id' do
    before { get :show, id: page_id, headers: authenticated_header }

    context 'when the record exists' do
      it 'returns the page' do
        expect(response.parsed_body['id']).to eq(page_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'returns status code 404' do
        get :show, id: -1, headers: authenticated_header
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe 'DELETE /:id' do
    it 'returns status code 204' do
      delete :destroy, id: page_id, headers: authenticated_header

      #expect(Page.find_by_id(page_id)).to be_nil
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404 if not found' do
      delete :destroy, id: -1, headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
