feature = <<~HEREDOC
  When administrator wants to delete user,
  he wants to delete specific confirmed user,
  so that user will be completely removed from the system
HEREDOC

RSpec.feature feature, issues: ['railgun#178'] do

  scenario = <<~HEREDOC
    Given administrator is on the Users page
    When he clicks 'Delete'
    Then user record has removed
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit staff_users_path

    click_link 'Delete', href: staff_user_path(user)
    # For an unspecified reason, the deletion occurs without an alert confirm
    #page.driver.browser.switch_to.alert.accept

    expect(User.find_by_id(user.id)).to be_nil
  end
end
