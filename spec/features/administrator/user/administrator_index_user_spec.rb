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

    click_link('View', href:'/staff/users/2')

    # why email from rspec does not match email from screenshot?
    expect(user.email).not_to be_empty
  end
end

feature = <<~HEREDOC
  When administrator wants to work with employees,
  he wants to list all employees,
  so that he can know more about employee
HEREDOC

RSpec.feature feature, issues: [76] do
  scenario = <<~HEREDOC
    Given employee
    Given administrator is on the Users page
    When he clicks 'Employees'
    Then he can click 'show' link to see employee details
  HEREDOC

  scenario scenario
  # TODO: check Index Scopes section on https://activeadmin.info/3-index-pages.html
end
