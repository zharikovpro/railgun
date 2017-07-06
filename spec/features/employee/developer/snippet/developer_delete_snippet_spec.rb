feature = <<~HEREDOC
  When developer wants to delete snippet,
  he wants to delete specific snippet with 'preloader' tag,
  so that snippet will be removed from application layout
HEREDOC

RSpec.feature feature, issues: ['railgun#184'] do
  scenario = <<~HEREDOC
    Given developer is on the Snippet page
    When he clicks 'Delete' and accepts confirmation
    Then snippet record has removed
  HEREDOC

  scenario scenario, :js do
    snippet = create(:snippet, slug: 'preloader')
    login_as create(:developer)
    visit staff_snippets_path

    click_link 'Delete', href: staff_snippet_path(snippet)
    page.accept_alert

    expect(page).not_to have_content(snippet.slug)
    expect(Snippet.find_by_slug('preloader')).to be_nil
  end
end
