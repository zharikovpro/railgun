feature = <<~HEREDOC
  When administrator wants to work with users,
  he wants to list all users,
  so that he can know more about user
HEREDOC

RSpec.feature feature, issues: [75] do
  scenario = <<~HEREDOC
    Given user
    When administrator visits users page
    Then he can click 'show' link to see user details
  HEREDOC

  scenario scenario
end

feature = <<~HEREDOC
  When administrator wants to work with employees,
  he wants to list all employees,
  so that he can know more about employee
HEREDOC

RSpec.feature feature, issues: [76] do
  scenario = <<~HEREDOC
    Given employee
    Given administrator is on the Employees page
    Then he can click 'show' link to see employee details
  HEREDOC

  scenario scenario
  # TODO: check Index Scopes section on https://activeadmin.info/3-index-pages.html
end
