RSpec.describe Page, issues: [97] do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of :slug }
end
