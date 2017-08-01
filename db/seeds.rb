# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

administrator = FactoryGirl.create(:user, email: 'root@mail.com', password: 'password', password_confirmation: 'password')
UserRole::TITLES.each { |title| UserRole.create(user: administrator, role: title) }
