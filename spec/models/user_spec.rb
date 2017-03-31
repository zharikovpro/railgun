RSpec.describe do
  it 'may have many roles', issues: [54] do
    it.is_expected.to have_many(:roles)
  end
end
