RSpec.describe do
  it 'may have many roles', issues: [54] do
    it.is_expected.to have_many(:roles)
  end

  context 'has role' do
    it 'is employee', issues: [76]
    # TODO: implement User#employee? method
  end
end
