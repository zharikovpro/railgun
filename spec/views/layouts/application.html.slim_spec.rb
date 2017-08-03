RSpec.describe 'layouts/application' do
  it 'given snippet with slug "head" renders it right before </head>', issues: ['railgun#41'] do
    snippet = create(:snippet, slug: 'head')

    render template: 'application/root', layout: 'layouts/application'

    expect(response).to match(%r{#{snippet.text}<\/head>})
  end
end
