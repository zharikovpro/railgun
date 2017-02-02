class ApplicationController < ActionController::Base
  helper_method :active_admin_root_path, :reincarnation?

  protect_from_forgery with: :exception

  include Pundit
  #after_action :verify_authorized, except: :index, unless: :devise_controller?
  #after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def pundit_user
    current_employee
  end

  def root
    if Rails.env.development? && Employee.count.zero?
      admin = Employee.create!(role: :admin, email: 'admin', password: 'admin', password_confirmation: 'admin')
      sign_in(admin, bypass: true)

      flash[:notice] = "Development mode, default admin employee created #{admin.email}"
      redirect_to active_admin_root_path
    else
      render 'root'
    end
  end

  def active_admin_root_path
    '/' + ActiveAdmin.application.default_namespace.to_s
  end

  def reincarnation?
    session[:reincarnated_employee_id].present?
  end
end
