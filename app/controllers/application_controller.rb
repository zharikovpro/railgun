class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def root
    if Rails.env.development?
      if AdminUser.count.zero?
        AdminUser.create!(email: 'admin', password: 'admin', password_confirmation: 'admin')
      end

      admin = AdminUser.first
      sign_in(admin, bypass: true)
      flash[:notice] = "Development mode, logged in as #{admin.email}"
      redirect_to '/' + ActiveAdmin.application.default_namespace.to_s
    else
      render plain: 'Hello!'
    end
  end
end
