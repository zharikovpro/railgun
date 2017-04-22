RSpec.describe Media, issues: [84] do
  it 'is versioned' do
    it.is_expected.to be_versioned
  end

  it 'is validated' do
    it.is_expected.to be_validate_attachment_presence(:attachment)
  end

  it 'do not validate file type' do
    it.is_expected.not_to validate_attachment_content_type(:file)
  end
end
