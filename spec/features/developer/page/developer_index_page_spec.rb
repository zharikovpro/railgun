feature = <<~HEREDOC
  When developer wants to edit page with markdown,
  he wants to list all pages with their slugs,
  so that he can find specific page by slug
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given page with slug 'faq'
    When developer visits pages
    Then he sees 'faq'
  HEREDOC

  scenario scenario do
  	create(:page, slug: 'faq')
  	login_as create(:developer)

  	visit staff_pages_path

  	expect(page).to have_content('faq')
  end
end
