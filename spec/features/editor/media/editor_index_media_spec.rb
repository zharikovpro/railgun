feature = <<~HEREDOC
  When editor wants to provide a link to the media file,
  he wants to list all files,
  so that he can find specific media file by slug
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given media with slug 'document'
    When editor visits media page
    Then he sees 'document'
  HEREDOC

  scenario scenario do
  	create(:media, slug: 'document')
  	login_as create(:editor)

  	visit staff_medias_path

  	expect(page).to have_content('document')
  end
end
