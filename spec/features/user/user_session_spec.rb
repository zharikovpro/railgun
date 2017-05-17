feature = <<~HEREDOC
  When user login he gets session,
  he have not been active in a specified period of time
  so expires session and user is logout
HEREDOC

RSpec.feature feature, issues: [111] do
  scenario = <<~HEREDOC
    Given user is on root page and sees self email
    When he have not been active in a 7 days
    Then expires session and user is logout and sees 'Hello, guest'
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
