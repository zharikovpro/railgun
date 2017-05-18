feature = <<~HEREDOC
  When visitor visits media URL,
  he wants to get media file,
  so that he can see file content
HEREDOC

RSpec.feature feature, issues: ['railgun#84'] do
  scenario = <<~HEREDOC
    Given media with slug 'image'
    When visitor visits this media URL
    Then he is redirected to file URL
  HEREDOC

  scenario scenario do
    media = create(:media, slug: 'image')

    expect{ visit media_path(media.slug) }.to raise_error(ActionController::RoutingError)

    expect(page.status_code).to eq(303)
    expect(page.current_url).to eq(media.file.url)
  end
end
