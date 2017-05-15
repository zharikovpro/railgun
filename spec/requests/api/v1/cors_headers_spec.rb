require 'spec_helper'

RSpec.describe 'API allows CORS', issues: [113] do
  it 'returns CORS headers' do
    get '/api/v1/pages', headers: { 'HTTP_ORIGIN' => 'http://super-test.com', 'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET' }

    expect(response.headers['Access-Control-Allow-Origin']).to eq('http://super-test.com')
    expect(response.headers['Access-Control-Allow-Methods']).to eq('GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS')
    expect(response.headers['Access-Control-Allow-Headers']).to be_nil
    expect(response.headers).to have_key('Access-Control-Max-Age')
  end
end
