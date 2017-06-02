RSpec.describe Media, issues: [84] do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of :slug }

  it 'has attached file' do
    is_expected.to have_attached_file(:file)
  end
end
