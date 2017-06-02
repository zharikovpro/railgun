RSpec.describe Page, issues: ['railgun#97'] do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of :slug }
end
