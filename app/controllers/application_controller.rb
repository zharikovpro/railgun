class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit
  before_action :authenticate!, only: :create if Rails.env.development?

  include Pundit
  after_action :verify_policy_scoped, only: :index, unless: :devise_or_active_admin_controller?
  after_action :verify_authorized, except: :index, unless: :devise_or_active_admin_controller?

  def root
    skip_authorization
    skip_policy_scope
  end

  private

  def authenticate!
    sign_in(resource_model(User, :email))
  end

  def resource_model(model, param)
    model.find_by("#{param}": params[model.name.underscore][param])
  end

  def active_admin_controller?
    params[:controller].start_with?(ActiveAdmin.application.default_namespace.to_s)
  end

  def devise_or_active_admin_controller?
    devise_controller? || active_admin_controller?
  end
end
