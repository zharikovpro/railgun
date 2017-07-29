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

  let(:rails_env) { 'development' }
  let!(:custom_env) { { 'RAILS_ENV' => rails_env } }

  #before(:each) { set_environment_variable 'RAILS_ENV', 'development' }

  before { allow(Rails).to receive(:env) { 'development'.inquiry } }
  #before { allow_any_instance_of(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development')) }
  #before { ENV.stub(env: ActiveSupport::StringInquirer.new('development')) }
  #let(:environment){:development}
  fscenario scenario do
    #allow(Rails.env).to receive(:development?).and_return(true)
    expect(Rails.env).to eq('development')
    user = create(:administrator)
    visit new_user_session_path
    #puts Rails.env.development?
    fill_in 'Email', with: user.email
    click_button 'Login'
    expect(page).to have_content('Signed in successfully.')
  end
end
