feature = <<~HEREDOC
  When developer visits non-staff page,
  he want to see installed analytics tracking code,
  so that he can confirm correct analytics code installation
HEREDOC

RSpec.feature feature, issues: [41] do
  scenario = <<~HEREDOC
    Given snippet with slug 'head' and text '<script>document.write('test');</script>'
    When developer visits root page
    Then he sees 'test'
  HEREDOC

  scenario scenario
  # visit root_path
  # expect(page).to have_content('test')
end
