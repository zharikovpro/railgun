feature = <<~HEREDOC
  When visitor visits media URL,
  he wants to get media file,
  so that he can see file content
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given media with slug 'image'
    When visitor visits this media URL
    Then he is redirected to file URL
  HEREDOC

  fscenario scenario do
    media = create(:media, slug: 'image')

    visit media_path(media.slug)

    #expect(response).to redirect_to
  end
end
