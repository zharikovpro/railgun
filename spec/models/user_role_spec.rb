RSpec.describe UserRole, issues: [54] do
  it 'belongs to user' do
    it.is_expected.to belong_to(:user)
  end

  it 'has predefined list of possible roles' do
    it.is_expected.to define_enum_for(:status).with([:administrator, :developer, :support, :moderator])
  end

  it 'is versioned' do
    it.is_expected.to be_versioned
  end
end
