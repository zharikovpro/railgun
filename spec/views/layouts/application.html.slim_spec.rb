RSpec.describe 'layouts/application' do
  it 'given snippet with slug "head" renders it right before </head>', issues: [41] do
    snippet = create(:snippet, slug: 'head')

    render template: 'application/root', layout: 'layouts/application'

    expect(response).to match /#{snippet.text}<\/head>/
  end
end
