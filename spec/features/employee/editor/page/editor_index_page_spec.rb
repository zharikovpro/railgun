feature = <<~HEREDOC
  When editor wants to edit page with markdown,
  he wants to list all pages with their slugs,
  so that he can find specific page by slug
HEREDOC

RSpec.feature feature, issues: ['railgun#97'] do
  scenario = <<~HEREDOC
    Given page with slug 'faq'
    When editor visits pages
    Then he sees 'faq'
  HEREDOC

  scenario scenario do
    create(:page, slug: 'faq')
    login_as create(:editor)

    visit staff_pages_path

    expect(page).to have_content('faq')
  end
end
