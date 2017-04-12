feature = <<~HEREDOC
  When developer wants to install analytics code snippet,
  he wants to create new code snippet with tag 'head',
  so that its text will be rendered in application layout
HEREDOC

RSpec.feature feature, issues: [89] do
  scenario = <<~HEREDOC
    Given developer is on the new snippet page
    When he fills in slug and text and clicks 'Create Snippet'
    Then new snippet record with that data is present
  HEREDOC

  scenario scenario
end
