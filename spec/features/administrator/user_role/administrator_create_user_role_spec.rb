feature = <<~HEREDOC
  When new employee is registered as a user,
  administrator wants to assign specific user role to him,
  so that employee can do work for that role
HEREDOC

RSpec.feature feature, issues: [54, 95] do

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he clicks Add Role, selects 'support' and clicks 'Update User'
    Then user has 'support' role
  HEREDOC

  scenario scenario, :js do
    user = create(:user)
    login_as create(:administrator)
    visit edit_staff_user_path(user)

    click_on 'Add Role'
    select 'support', from: 'Role'
    click_button 'Update User'

    expect(user.user_roles.first.role).to eq('support')
  end
end
