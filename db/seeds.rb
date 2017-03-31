# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

administrator = User.new(email: 'admin', password: 'admin', password_confirmation: 'admin')
# TODO: administrator.skip_confirmation!
# TODO: administrator.confirm
administrator.save
# TODO: UserRole.create!(grantor_id: administrator.id, role: :administrator)
