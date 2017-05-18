RSpec.describe UserPolicy, issues: ['railgun#54'] do
  subject { described_class }

  context 'administrator' do
    let(:administrator) { create(:administrator) }

    permissions :create?, :update? do
      it 'allow' do
        user_role = build(:user_role)

        is_expected.to permit(administrator, user_role)
      end

      it 'reads all users' do
        create(:user)

        resolved_scope = subject::Scope.new(administrator, User).resolve
        
        expect(resolved_scope.count).to eq(2)
      end
    end
  end
end
