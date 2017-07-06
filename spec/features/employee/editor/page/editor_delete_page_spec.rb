feature = <<~HEREDOC
  When editor wants to delete page,
  he wants to delete specific page with 'about' slug,
  so that page will be removed from view
HEREDOC

RSpec.feature feature, issues: ['railgun#184'] do
  scenario = <<~HEREDOC
    Given editor is on the Pages page
    When he clicks 'Delete' and accepts confirmation
    Then page record has removed
  HEREDOC

  scenario scenario, :js do
    del_page = create(:page, slug: 'about')
    login_as create(:editor)
    visit staff_pages_path

    click_link 'Delete', href: staff_page_path(del_page)
    page.accept_alert

    expect(page).not_to have_content(del_page.slug)
    expect(Page.find_by_slug('about')).to be_nil
  end
end
