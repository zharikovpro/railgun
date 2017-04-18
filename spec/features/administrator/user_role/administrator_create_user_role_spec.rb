feature = <<~HEREDOC
  When new employee is registered as a user,
  administrator wants to assign specific user role to him,
  so that employee can do work for that role
HEREDOC

RSpec.feature feature, issues: [54, 95] do
  scenario = <<~HEREDOC
    Given user
    Given administrator is on the edit user pages
    When he clicks 'Add Role'
    Then he is on new user role pages and sees user email
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit edit_staff_user_path(user)

    click_link 'Add Role'

    expect(page).to have_current_path(new_staff_user_role_path(user_id: user.id))
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
    expect(page).to have_content(user.email)

    select 'support', from: 'Role'
    click_button 'Create User role'

    expect(user.user_roles.first.role).to eq('support')
  end
end
