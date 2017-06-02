RSpec.describe UserRole, issues: [54] do
  it { is_expected.to be_versioned }

  it 'belongs to user' do
    is_expected.to belong_to(:user)
  end

  it 'has list of available role titles' do
    expect(subject.class::TITLES).to contain_exactly(:owner, :administrator, :developer, :editor, :support, :moderator)
  end
end
