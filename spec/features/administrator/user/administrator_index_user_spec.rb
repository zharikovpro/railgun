feature = <<~HEREDOC
  When administrator wants to work with users,
  he wants to list all users,
  so that he can know more about user
HEREDOC

RSpec.feature feature, issues: [75] do
  scenario = <<~HEREDOC
    Given user
    Given administrator is on the Users page
    When he clicks 'View'
    Then he sees user details
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)
    visit staff_users_path

    click_link('View', href: "/staff/users/#{user.id}")

    expect(page).to have_content(user.email)
  end
end

feature = <<~HEREDOC
  When administrator wants to work with employees,
  he wants to list all employees,
  so that he can know more about employees
HEREDOC

RSpec.feature feature, issues: [76] do
  scenario = <<~HEREDOC
    Given employee
    Given administrator is on the Users page
    When he clicks 'Employees'
    Then he sees only employees
  HEREDOC

  scenario scenario do
    create(:user)
    create(:developer)
    login_as create(:administrator)
    visit staff_users_path

    click_link('Employees')
    
    expect(User.employees.count).to eq(2)
  end
end
