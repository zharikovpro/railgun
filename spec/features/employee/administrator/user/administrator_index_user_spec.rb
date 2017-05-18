feature = <<~HEREDOC
  When administrator wants to work with users,
  he wants to list all users,
  so that he can know more about user
HEREDOC

RSpec.feature feature, issues: ['railgun#75'] do
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
  When administrator wants to work with employee
  and struggles to find 10 employee amongst 1000 users,
  he wants to quickly list only employee,
  so that he can work with them right away
HEREDOC

RSpec.feature feature, issues: ['railgun#76'] do
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
  When administrator wants to work with employee with specific role
  and struggles to find 3 editors amongst 100 employee,
  he wants to quickly filter employee list by 'editor' role,
  so that he can work with editors right away
HEREDOC

RSpec.feature feature, issues: ['railgun#82'] do
  scenario = <<~HEREDOC
    Given employee with role 'editor'
    Given employee with role 'support'
    Given administrator is on the Employees page
    When he selects 'editor' in 'Role' filter
    Then he sees only editor
  HEREDOC

  scenario scenario do
    editor = create(:editor)
    support = create(:support)
    admin = create(:administrator)

    login_as admin
    visit staff_users_path(scope: 'employee')

    select 'editor', from: 'Role'
    click_button('Filter')

    expect(page).to have_select 'Role', selected: 'editor'
    expect(page).to have_content editor.email
    expect(page).not_to have_content support.email
  end
end
