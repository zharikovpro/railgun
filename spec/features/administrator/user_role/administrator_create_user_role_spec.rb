feature = <<~HEREDOC
  When new employee is registered as a user,
  administrator wants to assign specific user role to him,
  so that employee can do work for that role
HEREDOC

RSpec.feature feature, issues: [54, 95] do
  scenario = <<~HEREDOC
    Given user
    Given administrator is on the users page
    When he clicks 'Add Role' certain user
    Then he is on new user role page for that user
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit staff_users_path

    click_link 'Add Role', href: new_staff_user_role_path(user_id: user.id)

    expect(page).to have_content(user.email)
  end

  scenario = <<~HEREDOC
    Given administrator is on the new user role page
    Given administrator sees user email
    When he selects role 'support' and clicks 'Create User role'
    Then user has 'support' role
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit new_staff_user_role_path(user_id: user.id)

    select 'support', from: 'Role'
    click_button 'Create User role'

    expect(user.user_roles.first.role).to eq('support')
  end
end
