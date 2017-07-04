feature = <<~HEREDOC
  When developer wants to delete snippet,
  he wants to delete specific snippet with tag 'head',
  so that snippet will be completely removed from the layout
HEREDOC

RSpec.feature feature, issues: ['railgun#181'] do
  scenario = <<~HEREDOC
    Given developer is on the Snippets page
    When he clicks 'Delete'
    Then new snippet record with that data is present
  HEREDOC

  scenario scenario do
    login_as create(:developer)
    visit new_staff_snippet_path

    fill_in 'snippet_slug', with: 'slug'
    fill_in 'snippet_text', with: 'text'
    click_button 'Create Snippet'

    expect(Snippet.find_by_slug(:slug).text).to eq('text')
  end
end
