feature = <<~HEREDOC
  When employee is fired,
  administrator wants to remove specific user role from user,
  so that employee can not do work for that role
HEREDOC

RSpec.feature feature, issues: [54] do

  scenario = <<~HEREDOC
    Given user with 'support' role
    Given administrator is on the edit user page
    When he checks Delete near 'support' and clicks 'Update User',
    Then user has no 'support' role
  HEREDOC

  scenario scenario do
    support = create(:support)
    login_as create(:administrator)
    visit edit_staff_user_path(support)

    check 'Delete'
    click_button 'Update User'

    expect(UserRole.all).to be_empty
  end
end
