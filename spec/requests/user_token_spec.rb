require 'rails_helper'

RSpec.describe Api::V1::UserTokenController, issues: [116] do
  it 'authenticates correctly' do
    user = create(:user)
    page_id = create(:page).id

    post '/api/v1/user_token', auth: { email: user.email, password: user.password }, format: 'json'
    token = response.parsed_body['jwt']
    get "/api/v1/pages/#{page_id}", headers: { 'Authorization' => "Bearer #{token}" }

    expect(response.parsed_body['id']).to eq(page_id)
    expect(response).to have_http_status(200)
  end
end

RSpec.describe 'the requests support CORS headers', issues: [113] do
  it 'Returns the response CORS headers' do
    get '/api/v1/pages', nil, 'HTTP_ORIGIN' => 'http://super-test.com'

    expect(response.headers['Access-Control-Allow-Origin']).to eq('http://super-test.com')
    expect(response.headers['Access-Control-Allow-Methods']).to eq('OPTIONS, HEAD, GET, POST, PUT, PATCH, DELETE')
    expect(response.headers['Access-Control-Allow-Headers']).to be_nil
    expect(response.headers).to have_key('Access-Control-Max-Age')
  end
end
