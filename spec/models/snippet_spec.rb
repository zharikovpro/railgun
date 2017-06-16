RSpec.describe Snippet, issues: ['railgun#41'] do
  it 'is versioned' do
    is_expected.to be_versioned
  end
  it { is_expected.to validate_presence_of :slug }
end
