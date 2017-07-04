RSpec.resource 'Users', issues: ['railgun#174'] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:administrator).api_token}" }
  let!(:users) { create_list(:user, 2) }
  response_field :id, 'User ID', 'Type' => 'Integer'
  response_field :email, 'Email', 'Type' => 'String'
  response_field :password, 'Password', 'Type' => 'String'
  response_field :password_confirmation, 'Password confirmation', 'Type' => 'String'

  get '/api/v1/users' do
    example_request 'List users' do
      explanation 'List all available users'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq(3)
    end
  end

  get '/api/v1/users/-1' do
    example_request 'resource not found' do
      explanation 'returns status 404'

      expect(status).to eq 404
    end
  end

  get '/api/v1/users/:id' do
    let(:user) { users.first }
    let(:id) { user.id }

    example_request 'Get specific user' do
      explanation 'Get a user by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['email']).to eq(user.email)
    end
  end

  post '/api/v1/users' do
    parameter :email, 'Email'
    parameter :password, 'password'
    parameter :password_confirmation, 'password'

    let(:email) { 'test@mail.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    let(:raw_post) { params.to_json }

    example_request 'Create user' do
      explanation 'Create the new user'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['email']).to eq(email)
      expect(User.find_by_email(email).valid_password?(password)).to be_truthy
    end
  end

  put '/api/v1/users/:id' do
    parameter :email, 'email'
    parameter :password, 'password'
    parameter :password_confirmation, 'password'

    let(:user) { users.first }
    let(:id) { user.id }

    let(:email) { 'test@mail.com' }
    let(:password) { 'new_updated_password' }
    let(:password_confirmation) { 'new_updated_password' }

    let(:raw_post) { params.to_json }

    example_request 'Update user' do
      explanation 'Update user with new content'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['email']).to eq(email)
      expect(User.find(id).valid_password?(password)).to be_truthy
    end
  end

  put '/api/v1/users/:id' do
    parameter :email, 'test@mail.com'
    parameter :password, ''
    parameter :password_confirmation, 'bad request'

    let(:user) { users.first }
    let(:id) { user.id }

    let(:email) { 'test@mail.com' }
    let(:password) { '' }
    let(:password_confirmation) { 'bad request' }

    let(:raw_post) { params.to_json }

    example_request 'Error when updates user' do
      explanation 'Params of user is not valid'

      expect(status).to eq 422
      expect(User.find(id).valid_password?(password)).not_to be_truthy
    end
  end

  delete '/api/v1/users/:id' do
    let(:user) { users.first }
    let(:id) { user.id }

    example_request 'Delete user' do
      explanation 'Deletes user and returns status 204'

      expect(status).to eq 204
      expect(User.find_by_id(user.id)).to be_nil
    end
  end
end
