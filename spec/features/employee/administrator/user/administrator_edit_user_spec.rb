feature = <<~HEREDOC
  When administrator wants to edit user valid credentials,
  he wants to edit just password of user by new and confirmationed password,
  he wants to edit others credentials of user without entering a password,
  so that user have beening  new credentials
HEREDOC

RSpec.feature feature, issues: ['railgun#151'] do
  before { login_as FactoryGirl.create(:administrator) }
  let(:user) { create(:user) }
  before { visit edit_staff_user_path(user) }

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he fills in email 'new@mail.com' with no entering a password and clicks 'Update User' button
    Then user record has credential emial 'new@mail.com'
  HEREDOC

  scenario scenario do
    fill_in 'Email', with: 'new@mail.com'
    click_button 'Update User'

    expect(User.find_by_id(user.id).email).to eq('new@mail.com')
  end

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he fills in new password 'qwerty' and same password confirmation and clicks 'Update User' button
    Then user record has new password 'qwerty'
  HEREDOC

  scenario scenario do
    fill_in 'Password', with: 'qwerty', match: :prefer_exact
    fill_in 'Password confirmation', with: 'qwerty', match: :prefer_exact
    click_button 'Update User'

    expect(User.find_by_id(user.id).valid_password?('qwerty')).to be true
  end
end
