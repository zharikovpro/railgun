require 'rails_helper'

RSpec.describe UserTokenController, issues: [116] do
  describe 'authenticate' do
    fit 'authenticates correctly' do
      user = create(:user)
      page_id = create(:page).id

      post '/user_token', auth: { email: user.email, password: user.password }, format: 'json'
      token = response.parsed_body['jwt']
      get "/api/v1/pages/#{page_id}", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response.parsed_body['id']).to eq(page_id)
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'CORS', issues: [113] do
  it 'Returns the response CORS headers' do
    get '/api/v1/pages', nil, 'HTTP_ORIGIN' => 'http://super-test.com'

    expect(response.headers['Access-Control-Allow-Origin']).to eq('http://super-test.com')
  end
end

=begin
RSpec.feature "the requests support CORS headers", type: :feature, issues: [113] do
  scenario 'Send the CORS preflight OPTIONS request' do
    options '/', nil, 'HTTP_ORIGIN' => 'http://super-test.com', 'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET', 'HTTP_ACCESS_CONTROL_REQUEST_HEADERS' => 'test'

    expect(last_response.headers['Access-Control-Allow-Origin']).to eq('http://super-test.com')
    expect(last_response.headers['Access-Control-Allow-Methods']).to eq('GET, POST, PATCH, OPTIONS')
    expect(last_response.headers['Access-Control-Allow-Headers']).to eq('test')
    expect(last_response.headers).to have_key('Access-Control-Max-Age')
  end
end
=end
