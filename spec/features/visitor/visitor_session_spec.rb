feature = <<~HEREDOC
  When visitor login he gets session,
  he have not been active in a specified period of time
  so expires session and visitor is logout
HEREDOC

RSpec.feature feature, issues: [111] do
  scenario = <<~HEREDOC
    Given visitor is on root page and sees self email
    When he have not been active in a 7 days
    Then expires session and visitor is logout and sees 'Hello, guest'
  HEREDOC

  scenario scenario do
    visitor = create(:user)
    login_as(visitor)
    visit root_path
    expect(page).to have_content(visitor.email)

    Timecop.travel(Time.now + 7.days)
    visit root_path

    expect(page).to have_content('Hello, guest')
    expect(visitor.timedout?(7.days.ago)).to be true
  end
end
