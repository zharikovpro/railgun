feature = <<~HEREDOC
  When administrator visits employee page,
  he wants to see list of his roles,
  so that he knows what this employee can do
HEREDOC

RSpec.feature feature, issues: [83] do
  scenario = <<~HEREDOC
    Given employee with roles 'editor' and 'support'
    When administrator visits this employee page
    Then in the User Details table 
    he sees 'Roles' and 'editor, support'
  HEREDOC

  fscenario scenario do
    employee = create(:editor)
    create(:user_role, :support, user: employee)
    login_as create(:administrator)

    visit staff_user_path(employee)

    expect(page).to have_content('Roles')
    expect(page).to have_content('editor, support')
  end
end
