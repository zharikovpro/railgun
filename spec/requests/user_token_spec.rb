require 'rails_helper'

RSpec.describe UserTokenController, issues: [116] do
  describe 'authenticate' do
    it 'authenticates correctly' do
      user = create(:user)
      token = Knock::AuthToken.new(payload: { sub: user.id }).token

      post '/user_token', auth: { email: user.email, password: user.password }, format: 'json'

      expect(response).to be_success
      expect(response.content_type).to match(/application\/json/)
      expect(response.body).to be{ json JWT: token }
    end
  end
end
