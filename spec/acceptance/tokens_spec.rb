RSpec.resource 'Tokens', issues: ['railgun#149'] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'

  let(:user) { create(:editor) }

  post '/api/v1/tokens' do
    parameter :auth, 'Token'

    let(:auth) { { email: user.email, password: user.password } }

    let(:raw_post) { params.to_json }

    example_request 'Get authenticate token' do
      explanation 'Create the new snippet'

      expect(status).to eq 201
      @@token = JSON.parse(response_body)['jwt']
      puts @@token
      puts user.api_token
    end
  end
end
