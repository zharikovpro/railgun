RSpec.describe PagePolicy, issues: [109] do
  subject { described_class }

  let(:page) { build(:page) }

  context 'editor' do
    permissions :create?, :update?, :destroy? do
      it 'allow' do
        editor = create(:editor)

        expect(subject).to permit(editor, page)
      end
    end
  end

  context 'visitor' do
    permissions :show? do
      it 'allow' do
        expect(subject).to permit(nil, :page)
      end
    end
  end
end
