feature = <<~HEREDOC
  When administrator wants to edit user valid credentials,
  he wants to edit just password of user by new and confirmationed password,
  he wants to edit others credentials of user without entering a password,
  so that user have beening  new credentials
HEREDOC

RSpec.feature feature, issues: ['railgun#151'] do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he fills in email 'new@mail.com' with no entering a password and clicks 'Update User' button
    Then user record has credential emial 'new@mail.com'
  HEREDOC

  fscenario scenario do
    login_as FactoryGirl.create(:administrator)
    visit new_staff_user_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password, match: :prefer_exact
    fill_in 'Password confirmation', with: password, match: :prefer_exact
    click_button 'Create User'

    expect(User.find_by_email(email).valid_password?(password)).to be_truthy
  end

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he fills in new password 'qwerty' and same password confirmation and clicks 'Update User' button
    Then user record has new password 'qwerty'
  HEREDOC

  fscenario scenario do
    login_as FactoryGirl.create(:administrator)
    visit new_staff_user_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password, match: :prefer_exact
    fill_in 'Password confirmation', with: password, match: :prefer_exact
    click_button 'Create User'

    expect(User.find_by_email(email).valid_password?(password)).to be_truthy
  end
end
