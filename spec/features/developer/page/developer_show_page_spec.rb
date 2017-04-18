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

  scenario scenario do
    page = create(:page, slug: 'faq', markdown: 'something')
    login_as create(:developer)

    visit staff_page_path(page.id)

    #expect(page).to have_content('something')
  end
end
