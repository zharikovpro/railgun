feature = <<~HEREDOC
  When developer wants to install analytics code snippet,
  he wants to create new code snippet with tag 'head',
  so that its text will be rendered in application layout
HEREDOC

RSpec.feature feature, issues: [89] do
  scenario = <<~HEREDOC
    Given developer is on the new snippet page
    When he fills in slug and text and clicks 'Create Snippet'
    Then new snippet record with that data is present
  HEREDOC

  scenario scenario do
    login_as create(:developer)
    visit new_staff_snippet_path

    fill_in 'snippet_slug', with: 'slug'
    fill_in 'snippet_text', with: 'text'
    click_button 'Create Snippet'

    expect(Snippet.find_by_slug(:slug)).to be_truthy
    expect(Snippet.find_by_slug(:slug).text).to eq('text')
  end
end
