class ApplicationController < ActionController::Base
  helper_method :reincarnation?

  protect_from_forgery with: :exception

  include Pundit
  #after_action :verify_authorized, except: :index, unless: :devise_controller?
  #after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def root
  end

  def reincarnation?
    session[:reincarnated_user_id].present?
  end
end
