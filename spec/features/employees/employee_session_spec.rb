feature = <<~HEREDOC
  When employee login he gets session,
  he have not been active in a specified period of time
  so expires session and employee is logout
HEREDOC

RSpec.feature feature, issues: [111] do
  scenario = <<~HEREDOC
    Given employee is logined
    When he have not been active in a 5 minutes
    Then expires session and employee is logout
  HEREDOC

  scenario scenario do
    employee = create(:owner)

    expect(employee.timedout?(6.minutes.ago)).to be true
  end
end
