feature = <<~HEREDOC
  When editor wants to provide a link to the media file,
  he wants to create new media file with slug 'image',
  so that editor can edit this media file
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given editor is on the new media page
    When he fills in slug and file and clicks 'Create Media'
    Then new media file record with that data is present
  HEREDOC

  scenario scenario do
    login_as create(:editor)
    visit new_staff_medium_path

    fill_in 'page_slug', with: 'faq'
    fill_in 'page_markdown', with: 'markdown'
    click_button 'Create Page'

    expect(Page.find_by_slug(:faq).markdown).to eq('markdown')
  end
end
