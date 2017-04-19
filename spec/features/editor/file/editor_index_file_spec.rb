feature = <<~HEREDOC
  When editor wants to provide a link to the document,
  he wants to list all files,
  so that he can find specific file by slug
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given file with slug 'document'
    When editor visits files page
    Then he sees 'document'
  HEREDOC

  scenario scenario do
  	create(:page, slug: 'faq')
  	login_as create(:editor)

  	visit staff_pages_path

  	expect(page).to have_content('faq')
  end
end
