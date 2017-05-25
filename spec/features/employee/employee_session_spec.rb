feature = <<~HEREDOC
  When employee is logged in,
  his session will be timed out after short period,
  so he will not forget to logout and will not compromise security
HEREDOC

RSpec.feature feature, issues: ['railgun#111'] do
  scenario = <<~HEREDOC
    Given employee is on the root page and sees welcome message with his email
    When he have been inactive for more than 5 minutes
    Then session will expire, employee will become visitor and see general welcome message
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
