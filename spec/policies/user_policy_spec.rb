RSpec.describe UserPolicy, issues: [54] do
  subject { described_class }

  permissions :create? do
    fit 'is allowed for administrator' do
      administrator = create(:administrator)

      user = build(:user)

      expect(subject).to permit(administrator, user)
    end
  end
end
