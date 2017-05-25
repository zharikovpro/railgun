feature = <<~HEREDOC
  When developer visits non-staff page,
  he want to see installed analytics tracking code,
  so that he can confirm correct analytics code installation
HEREDOC

RSpec.feature feature, issues: ['railgun#41'] do
  scenario = <<~HEREDOC
    Given snippet with slug 'head' and text '<script>alert('test');</script>'
    When developer visits root page
    Then he sees 'test'
  HEREDOC

  scenario scenario, :js do
    create(:snippet, slug: 'head', text: "<script>alert('test');</script>")
    login_as create(:developer)

    visit root_path

    expect(page.accept_alert).to eq('test')
  end
end
