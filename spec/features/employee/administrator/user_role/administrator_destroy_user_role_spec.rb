feature = <<~HEREDOC
  When employee is fired,
  administrator wants to remove specific user role from user,
  so that employee can not do work for that role
HEREDOC

RSpec.feature feature, issues: ['railgun#54', 'railgun#95'] do
  scenario = <<~HEREDOC
    Given user with 'support' role
    Given administrator is on the user roles page
    When he clicks 'Delete' support role and accept confirm
    Then user has no 'support' role
  HEREDOC

  scenario scenario, :js do
    support = create(:support)
    role = support.user_roles[0]
    login_as create(:administrator)
    visit staff_user_roles_path

    click_link 'Delete', href: staff_user_role_path(role.id)
    page.accept_alert

    expect(page).not_to have_content(role)
    expect(support.reload.user_roles).to be_empty
  end
end
