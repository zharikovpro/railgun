RSpec.describe do
  it 'belongs to user' do
    it.is_expected.to belong_to(:user)
  end

  it 'has predefined list of roles' do
    it.is_expected.to define_enum_for(:status).with([:administrator, :developer, :support, :moderator])
  end
end
