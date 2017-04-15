feature = <<~HEREDOC
  When employee is fired,
  administrator wants to remove specific user role from user,
  so that employee can not do work for that role
HEREDOC

RSpec.feature feature, issues: [54, 95] do
  scenario = <<~HEREDOC
    Given user with 'support' role
    Given administrator is on the user roles page
    When he click 'Delete' a certain role
    Then user has no 'support' role
  HEREDOC

  scenario scenario do
    support = create(:support)
    login_as create(:administrator)
    visit staff_user_roles_path

    click_link 'Delete', href: staff_user_role_path(support.user_roles[0].id)

    expect(support.reload.user_roles).to be_empty
  end
end
