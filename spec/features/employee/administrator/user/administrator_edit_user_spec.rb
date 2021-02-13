feature = <<~HEREDOC
  When user profile changes,
  administrator wants to edit user profile,
  so that it contains actual data
HEREDOC

RSpec.feature feature, issues: ['railgun#151'] do
  before { login_as FactoryBot.create(:administrator) }
  let(:user) { create(:user) }
  before { visit edit_staff_user_path(user) }

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he fills in email 'new@mail.com' and clicks 'Update User'
    Then user has email 'new@mail.com'
  HEREDOC

  scenario scenario do
    fill_in 'Email', with: 'new@mail.com'
    click_button 'Update User'

    expect(User.find_by_id(user.id).email).to eq('new@mail.com')
  end

  scenario = <<~HEREDOC
    Given administrator is on the edit user page
    When he types 'qwerty' as new password and password confirmation and clicks 'Update User'
    Then user record has new password 'qwerty'
  HEREDOC

  scenario scenario do
    fill_in 'Password', with: 'qwerty', match: :prefer_exact
    fill_in 'Password confirmation', with: 'qwerty', match: :prefer_exact
    click_button 'Update User'

    expect(User.find_by_id(user.id).valid_password?('qwerty')).to be true
  end
end
