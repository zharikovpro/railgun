RSpec.describe do
  it 'may have many roles' do
    it.is_expected.to have_many(:roles)
  end
end
