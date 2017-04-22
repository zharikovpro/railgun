feature = <<~HEREDOC
  When editor wants to update IMAGE media content,
  he wants to edit page with slug 'image',
  so that it has new content
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given page with slug 'image' and file_file_name 'image.jpg'
    Given editor is on the edit page
    When he types 'logo.png' as file_file_name and clicks 'Update page'
    Then page record has file_file_name 'logo.png'
  HEREDOC

  scenario scenario do
    media = create(:media, slug: 'image', file_file_name: 'image.jpg')
    login_as create(:editor)
    visit edit_staff_media_path(media)

    attach_file('media_file', Rails.root + 'spec/media/images/demo.jpg')
    click_button 'Update Media'

    expect(Media.find_by_slug(:image).file_file_name).to eq('demo.jpg')
  end
end
