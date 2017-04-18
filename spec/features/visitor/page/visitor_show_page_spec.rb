feature = <<~HEREDOC
  When visitor finds site in google,
  he wants to visit roo page,
  so that he can read content
HEREDOC

RSpec.feature feature, issues: [41] do
  scenario = <<~HEREDOC
    Given link to the domain
    When visitor visits root page
    Then he sees 'Hello'
  HEREDOC

  scenario scenario do
    link = root_url

    visit link

    expect(page).to have_content('Hello')
  end
end

feature = <<~HEREDOC
  When visitor visits page URL,
  he want to see formatted content,
  so that he can find important words faster
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given page with slug 'faq' and markdown '*italic*'
    When developer visits FAQ page
    Then he sees formatted 'italic' text
  HEREDOC

  scenario scenario do
    faq = create(:page, slug: 'faq', markdown: '*italic*')
    login_as create(:developer)

    visit page_path(faq.slug)

    expect(page).to have_css('em', text: 'italic')
  end
end
