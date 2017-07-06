feature = <<~HEREDOC
  When administrator wants to delete user,
  he wants to delete specific confirmed user,
  so that user will be completely removed from the system
HEREDOC

RSpec.feature feature, issues: ['railgun#178'] do

  scenario = <<~HEREDOC
    Given administrator is on the Users page
    When he clicks 'Delete' and accepts confirmation
    Then user record has removed
  HEREDOC

  scenario scenario, :js do
    user = create(:user)

    login_as create(:administrator)
    visit staff_users_path

    click_link 'Delete', href: staff_user_path(user)
    page.accept_alert

    expect(page).not_to have_content(user.email)
    expect(User.find_by_id(user.id)).to be_nil
  end
end
