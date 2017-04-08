feature = <<~HEREDOC
  When administrator wants to work with users,
  he wants to list all users,
  so that he can read user details
HEREDOC

RSpec.feature feature, issues: [75] do
  scenario = <<~HEREDOC
    Given user 
    When administrator visits users page,
    Then he can click 'show' link to see user details
  HEREDOC

  scenario scenario
end
