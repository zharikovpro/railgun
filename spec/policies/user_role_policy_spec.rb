RSpec.describe UserRolePolicy, issues: [54] do
  subject { described_class }

  context 'administrator' do
    permissions :create?, :destroy? do
      it 'allow' do
        administrator = create(:administrator)
        user = create(:user)

        user_role = build(:user_role, :support, user: user)

        is_expected.to permit(administrator, user_role)
      end
    end
  end
end
