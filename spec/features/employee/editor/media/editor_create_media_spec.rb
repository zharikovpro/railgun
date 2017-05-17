feature = <<~HEREDOC
  When editor wants to provide a link to the media file,
  he wants to create new media file with slug 'image',
  so that editor can edit this media file
HEREDOC

RSpec.feature feature, issues: [84] do
  scenario = <<~HEREDOC
    Given editor is on the new media page
    When he fills in slug and attachment file and clicks 'Create Media'
    Then new media file record with that data is present
  HEREDOC

  scenario scenario do
    login_as create(:editor)
    visit new_staff_media_path

    fill_in 'media_slug', with: 'image'
    attach_file('media_file', Rails.root + 'spec/fixtures/files/images/demo.jpg')
    click_button 'Create Media'

    expect(Media.find_by_slug(:image).file_file_name).to eq('demo.jpg')
  end
end
