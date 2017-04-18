feature = <<~HEREDOC
  When visitor finds site in google,
  he wants to visit roo pages,
  so that he can read content
HEREDOC

RSpec.feature feature, issues: [41] do
  scenario = <<~HEREDOC
    Given link to the domain
    When visitor visits root pages
    Then he sees 'Hello'
  HEREDOC

  scenario scenario do
    link = root_url

    visit link

    expect(page).to have_content('Hello')
  end
end

feature = <<~HEREDOC
  When developer visits non-staff pages,
  he want to see installed analytics tracking code,
  so that he can confirm correct analytics code installation
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given page with slug 'faq' and markdown 'something'
    When developer visits root pages
    Then he sees 'test'
  HEREDOC

  fscenario scenario do
    page = create(:page, slug: 'faq', markdown: '*123*')
    login_as create(:developer)

    visit page_path(page.slug)

    expect(page).to have_selector('em')
  end
end
