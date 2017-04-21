RSpec.describe Page, issues: [84] do
  it 'is versioned' do
    it.is_expected.to be_versioned
  end

  it { should validate_attachment_presence(:attachment) }
end
