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

  fscenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit staff_users_path

    click_on 'Add Role'
    select 'support', from: 'Role'
    click_button 'Update User'

    expect(user.user_roles.first.role).to eq('support')
  end

  scenario = <<~HEREDOC
    Given administrator is on the new user role page
    Given administrator sees user email
    When he selects role 'support' and clicks 'create user role'
    Then user has 'support' role
  HEREDOC

  fscenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit staff_users_path

    click_on 'Add Role'
    select 'support', from: 'Role'
    click_button 'Update User'

    expect(user.user_roles.first.role).to eq('support')
  end
end
