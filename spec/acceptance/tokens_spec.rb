RSpec.resource 'Tokens', issues: ['railgun#149'] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'

  let(:user) { create(:editor) }

  post '/api/v1/tokens' do
    parameter :auth, 'Email and Password'

    let(:auth) { { email: user.email, password: user.password } }

    let(:raw_post) { params.to_json }

    example_request 'Get authenticate token' do
      explanation 'User get token with verified signature'

      token = JSON.parse(response_body)['jwt']
      secret = Rails.application.secrets.secret_key_base

      expect(status).to eq 201
      expect(JWT.decode(token, secret)[0]['sub']).to eq(user.id)
    end
  end
end
