feature = <<~HEREDOC
  When administrator visits user page,
  he wants to see his email,
  so that administrator is sure he works with correct user
HEREDOC

RSpec.feature feature, issues: [83, 105] do
  scenario = <<~HEREDOC
    Given user
    When administrator visits this user page
    Then he sees his email
  HEREDOC

  scenario scenario do
    user = create(:user)
    login_as create(:administrator)

    visit staff_user_path(user)

    expect(page).to have_content(user.email)
  end
end
