require 'factory_bot_rails'

namespace :factory_bot do
  # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#linting-factories
  desc 'Verify that all FactoryBot factories and traits are valid'

  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        FactoryBot.lint(traits: true)
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rails factory_girl:lint RAILS_ENV='test'")
    end
  end
end
