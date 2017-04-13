feature = <<~HEREDOC
  When developer wants to edit code snippet,
  he wants to list all snippets with their slugs,
  so that he can find specific snippet by slug
HEREDOC

RSpec.feature feature, issues: [88] do
  scenario = <<~HEREDOC
    Given snippet with slug 'copyright'
    When developer visits snippets page
    Then he sees 'copyright'
  HEREDOC

  scenario scenario do
  	create(:snippet, slug: 'copyright')
  	login_as create(:developer)

  	visit staff_snippets_path

  	expect(page).to have_content('copyright')
  end
end