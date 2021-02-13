feature = <<~HEREDOC
  When administrator wants to quickly give user valid credentials,
  he wants to create confirmed user with specific email and password,
  so that user can use them to login immediately
HEREDOC

RSpec.feature feature, issues: ['railgun#95'] do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  scenario = <<~HEREDOC
    Given administrator is on the new user page
    When he fills in email and password and clicks 'Create User' button
    Then new user record with that credentials is present
  HEREDOC

  scenario scenario do
    login_as FactoryBot.create(:administrator)
    visit new_staff_user_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password, match: :prefer_exact
    fill_in 'Password confirmation', with: password, match: :prefer_exact
    click_button 'Create User'

    expect(User.find_by_email(email).valid_password?(password)).to be_truthy
  end
end
