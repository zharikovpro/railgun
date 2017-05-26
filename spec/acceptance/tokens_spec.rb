RSpec.resource 'Tokens', issues: ['railgun#149'] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'

  let(:user) { create(:user) }

  post '/api/v1/tokens' do
    parameter :auth, 'Token'

    let(:auth) { { email: user.email, password: user.password } }

    let(:raw_post) { params.to_json }

    example_request 'Get authenticate token' do
      explanation 'Create the new snippet'

      expect(status).to eq 201
    end
  end
end
=begin
it 'authenticates correctly' do
  user = create(:user)
  page_id = create(:page).id

  post '/api/v1/tokens', params: { auth: { email: user.email, password: user.password } }
  token = response.parsed_body['jwt']
  expect(response).to have_http_status(201)
  get "/api/v1/pages/#{page_id}", headers: { 'Authorization' => "Bearer #{token}" }

  expect(response.parsed_body['id']).to eq(page_id)
  expect(response).to have_http_status(200)
end
=end
