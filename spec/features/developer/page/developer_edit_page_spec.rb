feature = <<~HEREDOC
  When developer wants to update analytics code page,
  he wants to edit code page with tag 'faq',
  so that it has new markdown
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given page with slug 'faq' and markdown 'one'
    Given developer is on the edit page
    When he types 'two' as markdown and clicks 'Update page'
    Then page record has markdown 'two'
  HEREDOC

  scenario scenario do
    page = create(:page, slug: 'faq', markdown: 'one')
    login_as create(:developer)
    visit edit_staff_page_path(page)

    fill_in 'page_markdown', with: 'two'
    click_button 'Update Page'

    expect(Page.find_by_slug(:faq).markdown).to eq('two')
  end
end
