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
    he sees 'ROLES' and 'editor, support'
  HEREDOC

  scenario scenario
end
