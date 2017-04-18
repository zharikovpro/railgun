feature = <<~HEREDOC
  When developer wants to install analytics code page,
  he wants to create new code page with tag 'faq',
  so that its markdown will be rendered
HEREDOC

RSpec.feature feature, issues: [97] do
  scenario = <<~HEREDOC
    Given developer is on the new snippet page
    When he fills in slug and text and clicks 'Create Page'
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
