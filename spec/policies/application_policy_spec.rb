RSpec.describe ApplicationPolicy, issues: ['railgun#167'] do
  subject { described_class }

  context 'All permissions denied by default for' do
    UserRole::TITLES.each do |user|
      it "#{user}" do
        expect(Pundit.policy_scope(create(user), nil)).to be nil
      end
    end

    it 'not existened user' do
      expect(Pundit.policy_scope(nil, nil)).to be nil
    end
  end
end
