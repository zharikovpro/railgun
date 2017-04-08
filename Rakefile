# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# for Heroku CI setup phase
Rake::Task['db:schema:load'].clear
task 'db:schema:load' do
  Rake::Task['db:structure:load'].invoke
end

# run all specs like on the CI server
task 'ci' do
  system('bundle exec rake factory_girl:lint && CI=1 bundle exec rspec')
end
