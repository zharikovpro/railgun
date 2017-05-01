require 'rails_helper'

RSpec.describe UserTokenController, issues: [116] do
  describe 'authenticate' do
    it 'authenticates correctly' do
      user = create(:user)
      page = create(:page).id

      post '/user_token', auth: { email: user.email, password: user.password }, format: 'json'
      token = JSON.parse(response.body)["jwt"]
      get "/api/v1/pages/#{page}", headers: { 'Authorization': "Bearer #{token}" }

      expect(response).to be_success
      expect(response.content_type).to match(/application\/json/)
      expect(json['id']).to eq(page)
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'Cors', issues: [113] do
  it 'Returns the response CORS headers' do
    get '/api/v1/pages', nil, 'HTTP_ORIGIN' => '*'

    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
  end
end
