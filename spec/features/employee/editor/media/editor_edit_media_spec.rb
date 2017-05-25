feature = <<~HEREDOC
  When editor wants to change photo,
  he wants to edit media with slug 'image',
  so that it has new content
HEREDOC

RSpec.feature feature, issues: ['railgun#84'] do
  scenario = <<~HEREDOC
    Given page with slug 'image' and file_file_name 'image.jpg'
    Given editor is on the edit page
    When he attaches file 'demo.jpg' and clicks 'Update page'
    Then media record has file_file_name 'demo.jpg'
  HEREDOC

  scenario scenario do
    media = create(:media, slug: 'image', file_file_name: 'image.jpg')
    login_as create(:editor)
    visit edit_staff_media_path(media)

    attach_file('media_file', Rails.root + 'spec/fixtures/files/images/demo.jpg')
    click_button 'Update Media'

    expect(Media.find_by_slug(:image).file_file_name).to eq('demo.jpg')
  end
end
