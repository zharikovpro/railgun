RSpec.describe Media, issues: ['railgun#84'] do
  it 'is versioned' do
    is_expected.to be_versioned
  end

  it 'has attached file' do
    is_expected.to have_attached_file(:file)
  end
end
