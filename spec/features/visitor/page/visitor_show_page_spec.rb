feature = <<~HEREDOC
  When visitor finds site in google,
  he wants to visit roo page,
  so that he can read content
HEREDOC

RSpec.feature feature, issues: [41] do
  scenario = <<~HEREDOC
    Given link to the domain
    When visitor visits root page
    Then he sees 'Hello'
  HEREDOC

  scenario scenario do
    link = root_url

    visit link

    expect(page).to have_content('Hello')
  end
end
