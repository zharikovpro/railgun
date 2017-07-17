feature = <<~HEREDOC
  When developer in development environment,
  he want quickly login into staff area,
  so under any account he can to login without password
HEREDOC

RSpec.feature feature, issues: ['railgun#192'] do
  scenario = <<~HEREDOC
    Given employee is on staff login page 
    When development mode is on he login into staff area without password
    Then he is logged in
  HEREDOC

  fscenario scenario do
    employee = create(:administrator)
    Rails.env = 'development'
    visit new_user_session_path

    fill_in 'Email', with: employee.email
    click_button 'Login'

    expect(page).to have_content('Signed in successfully.')
  end
end
