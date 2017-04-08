class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit

  # TODO: include Pundit
  # TODO: after_action :verify_authorized, except: :index, unless: :devise_controller?
  # TODO: after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def root
  end

  # def user_reincarnated?
  #   session[:reincarnated_user_id].present?
  # end
end
