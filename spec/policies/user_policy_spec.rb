RSpec.describe UserPolicy, issues: [54] do
  subject { described_class }

  context 'administrator' do
    permissions :create?, :update? do
      it 'allow' do
        administrator = create(:administrator)

        user_role = build(:user_role)

        expect(subject).to permit(administrator, user_role)
      end
    end
  end
end
