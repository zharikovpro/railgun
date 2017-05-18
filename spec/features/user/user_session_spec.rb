feature = <<~HEREDOC
  When user is logged in,
  his session will be timed out after long time,
  so he will not need to login frequently
HEREDOC

RSpec.feature feature, issues: ['railgun#111'] do
  scenario = <<~HEREDOC
    Given user is on the root page and sees welcome message with his email
    When he have been inactive for more than 7 days
    Then session will expire, user will become visitor and see general welcome message
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as(user)
    visit root_path
    expect(page).to have_content(user.email)

    travel(7.days)
    visit root_path

    expect(page).to have_content('Hello, guest')
    expect(user.timedout?(7.days.ago)).to be true
  end
end
