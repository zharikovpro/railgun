feature = <<~HEREDOC
  When developer wants to create formatted FAQ page,
  he wants to create new page with slug 'faq',
  so that editor can edit this page
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given developer is on the new page URL
    When he fills in slug and markdown and clicks 'Create Page'
    Then new page record with that data is present
  HEREDOC

  scenario scenario do
    login_as create(:developer)
    visit new_staff_page_path

    fill_in 'page_slug', with: 'faq'
    fill_in 'page_markdown', with: 'markdown'
    click_button 'Create Page'

    expect(Page.find_by_slug(:faq).markdown).to eq('markdown')
  end
end
