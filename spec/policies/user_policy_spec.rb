RSpec.describe UserPolicy, issues: [54] do
  subject { described_class }

  context 'administrator manages users' do
    permissions :create?, :update? do
      it 'allowed' do
        administrator = create(:administrator)

        user = build(:user)

        expect(subject).to permit(administrator, user)
      end
    end
  end
end
