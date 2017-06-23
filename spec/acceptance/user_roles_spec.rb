RSpec.resource 'UserRoles', issues: ['railgun#168'] do
  header 'Host', 'localhost:5000'
  header 'Content-Type', 'application/json'
  before { header 'Authorization', "Bearer #{create(:administrator).api_token}" }
  let!(:user) { create(:user) }
  let!(:user_role) { user.add_role(:owner) }
  response_field :id, 'ID', 'Type' => 'Integer'
  response_field :user_id, 'user ID', 'Type' => 'Integer'
  response_field :roles, 'Name of role', 'Type' => 'String'

  get '/api/v1/user_roles' do
    example_request 'List user_roles' do
      explanation 'List all available user_roles'

      expect(status).to eq 200
      expect(JSON.parse(response_body).size).to eq(2)
    end
  end

  get '/api/v1/user_roles/-1' do
    example_request 'resource not found' do
      explanation 'returns status 404'

      expect(status).to eq 404
    end
  end

  get '/api/v1/user_roles/:id' do
    let(:id) { user_role.id }
    let(:roles) { user.roles }

    example_request 'Get specific user_role' do
      explanation 'Get a user_role by id'

      expect(status).to eq 200
      expect(JSON.parse(response_body)['role']).to match("#{user.roles[0]}")
    end
  end

  post '/api/v1/user_roles' do
    parameter :user_id, 'User ID'
    parameter :role, 'User role'

    let(:user_id) { "#{user.id}" }
    let(:role) { 'editor' }

    let(:raw_post) { params.to_json }

    example_request 'Create user role' do
      explanation 'Create the new user role'

      expect(status).to eq 201
      expect(JSON.parse(response_body)['role']).to include('editor')
      expect(User.find(user.id).roles).to include(:editor)
    end
  end
end
