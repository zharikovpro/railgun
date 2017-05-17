feature = <<~HEREDOC
  When employee login he gets session,
  he have not been active in a specified period of time
  so expires session and employee is logout
HEREDOC

RSpec.feature feature, issues: [111] do
  scenario = <<~HEREDOC
    Given employee is on root page and sees self email
    When he have not been active in a 5 minutes
    Then expires session and employee is logout and sees 'Hello, guest'
  HEREDOC

  scenario scenario do
    employee = create(:owner)
    login_as(employee)
    visit root_path
    expect(page).to have_content(employee.email)

    travel(5.minutes)
    visit root_path

    expect(page).to have_content('Hello, guest')
    expect(employee.timedout?(5.minutes.ago)).to be true
  end
end
