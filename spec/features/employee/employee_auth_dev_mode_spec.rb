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

  scenario scenario, :js do
    employee = create(:owner)
    visit root_path
    expect(page).to have_content('Hello, guest')

    find('#any_login').click
    find('#selected_id').find(:option, "#{employee.email}").select_option

    expect(page).to have_content("Hello, #{employee.email}")
  end
end
