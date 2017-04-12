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
  When administrator wants to work with employees
  and struggles to find 10 employees amongst 1000 users,
  he wants to quickly list only employees,
  so that he can work with them right away
HEREDOC

RSpec.feature feature, issues: [76] do
  scenario = <<~HEREDOC
    Given user
    Given employee
    Given administrator is on the Users page
    When he clicks 'Employees'
    Then he sees only employee
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

feature = <<~HEREDOC
  When administrator wants to work with employees with specific role
  and struggles to find 3 editors amongst 100 employees,
  he wants to quickly filter employees list by 'editor' role,
  so that he can work with editors right away
HEREDOC

RSpec.feature feature, issues: [82] do
  scenario = <<~HEREDOC
    Given employee with role 'editor'
    Given employee with role 'support'
    Given administrator is on the Employees page
    When he selects 'editor' in 'Role' filter
    Then he sees only editor
  HEREDOC

  scenario scenario do
    create(:editor)
    create(:support)
    login_as create(:administrator)
    visit staff_users_path(scope: 'employees')

    select "editor", from: "Role"
    click_button('Filter')

    expect(page).to have_select 'Role', selected: 'editor'
    expect(page.all(:css, 'table').size).to eq(1)
  end
end
