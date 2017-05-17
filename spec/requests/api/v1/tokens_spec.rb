require 'rails_helper'

RSpec.describe API::V1::UserTokenController, issues: [116] do
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
end
