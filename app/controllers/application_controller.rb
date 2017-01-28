class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  def pundit_user
    current_employee
  end

  def root
    if Rails.env.development?
      if Employee.count.zero?
        Employee.create!(role: :admin, email: 'admin', password: 'admin', password_confirmation: 'admin')
      end

      admin = Employee.first
      sign_in(admin, bypass: true)
      flash[:notice] = "Development mode, logged in as #{admin.email}"
      redirect_to '/' + ActiveAdmin.application.default_namespace.to_s
    else
      render plain: 'Hello!'
    end
  end
end
