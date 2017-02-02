class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit
  #after_action :verify_authorized, except: :index, unless: :devise_controller?
  #after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

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
      redirect_to active_admin_root_path
    else
      render plain: 'Hello!'
    end
  end

  def active_admin_root_path
    '/' + ActiveAdmin.application.default_namespace.to_s
  end

  def reincarnation?
    session[:reincarnated_employee_id].present?
  end
  helper_method :reincarnation?
end
