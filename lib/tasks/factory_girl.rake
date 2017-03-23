require 'factory_girl_rails'

namespace :factory_girl do
  # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#linting-factories
  desc 'Verify that all FactoryGirl factories and traits are valid'

  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        FactoryGirl.lint(traits: true)
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rails factory_girl:lint RAILS_ENV='test'")
    end
  end
end
