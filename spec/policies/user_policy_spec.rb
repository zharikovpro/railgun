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

  context 'user' do
    let(:user) { create(:user) }

    permissions :graphiql? do
      it 'allow' do
        is_expected.to permit(user)
      end
    end
  end

  context 'not user' do
    permissions :graphiql? do
      it 'denied' do
        is_expected.not_to permit(nil)
      end
    end
  end
end
