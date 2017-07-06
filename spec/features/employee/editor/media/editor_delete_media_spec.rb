feature = <<~HEREDOC
  When editor wants to delete media,
  he wants to delete specific media with 'img' slug,
  so that media file will be removed
HEREDOC

RSpec.feature feature, issues: ['railgun#184'] do
  scenario = <<~HEREDOC
    Given editor is on the Medias page
    When he clicks 'Delete' and accepts confirmation
    Then media file record has removed
  HEREDOC

  scenario scenario, :js do
    media = create(:media, slug: 'img')
    login_as create(:editor)
    visit staff_medias_path

    click_link 'Delete', href: staff_media_path(media)
    page.accept_alert

    expect(page).not_to have_content(media.slug)
    expect(Media.find_by_slug('img')).to be_nil
  end
end
