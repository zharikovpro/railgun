feature = <<~HEREDOC
  When developer wants to update analytics code snippet,
  he wants to edit code snippet with tag 'head',
  so that it has new text
HEREDOC

RSpec.feature feature, issues: [90] do
  scenario = <<~HEREDOC
    Given snippet with slug 'head' and text 'one'
    Given developer is on the edit snippet page
    When he types 'two' as text and clicks 'Update Snippet'
    Then snippet record has text 'two'
  HEREDOC

  scenario scenario
end
