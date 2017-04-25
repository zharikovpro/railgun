RSpec.describe Media, issues: [84] do
  it 'is versioned' do
    is_expected.to be_versioned
  end

  it 'has attached file' do
    is_expected.to have_attached_file(:file)
  end

  # TODO: fit 'do not validate file type' do
  #   is_expected.not_to validate_attachment_content_type(:file)
  # end
end
