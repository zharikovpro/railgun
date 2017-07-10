feature = <<~HEREDOC
  When administrator wants to delete user,
  he wants to delete specific confirmed user,
  so that user will be completely removed from the system
HEREDOC

RSpec.feature feature, issues: ['railgun#178'] do
  before { login_as create(:administrator) }
  let!(:user) { create(:user) }
  let!(:employee) { create(:owner) }
  before { visit staff_users_path }

  scenario = <<~HEREDOC
    Given administrator is on the Users page
    When he clicks 'Delete' and accepts confirmation
    Then user record has removed
  HEREDOC

  scenario scenario, :js do
    click_link 'Delete', href: staff_user_path(user)
    page.accept_alert

    expect(page).not_to have_content(user.email)
    expect(User.find_by_id(user.id)).to be_nil
  end

  scenario = <<~HEREDOC
    Given administrator is on the Users page
    When he clicks 'Delete' and accepts confirmation
    Then employee record has removed with all roles
  HEREDOC

  scenario scenario, :js, issues: ['railgun#186'] do
    click_link 'Delete', href: staff_user_path(employee)
    page.accept_alert

    expect(page).not_to have_content(employee.email)
    expect(User.find_by_id(employee.id)).to be_nil
  end
end
