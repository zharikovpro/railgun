require 'rails_helper'

RSpec.describe UserTokenController, issues: [116] do
  describe 'authenticate' do
    it 'authenticates correctly' do
      user = create(:user)
      token = Knock::AuthToken.new(payload: { sub: user.id }).token

      post '/user_token', auth: { email: user.email, password: user.password }, format: 'json'

      expect(response).to be_success
      expect(response.content_type).to match(/application\/json/)
      expect(response.body).to eq({jwt: token}.to_json)
    end
  end
end

RSpec.describe 'Cors', issues: [113] do
  it 'Returns the response CORS headers' do
    get '/api/v1/pages', nil, 'HTTP_ORIGIN' => '*'

    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
  end
end
