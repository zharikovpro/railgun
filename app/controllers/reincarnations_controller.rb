class ReincarnationsController < ApplicationController
  def create
    user = User.find(params[:user_id])

    unless ReincarnationPolicy.new(current_user, user).create?
      raise Pundit::NotAuthorizedError
    end

    session[:reincarnated_user_id] = current_user.id
    sign_in user

    redirect_to root_path, notice: "Reincarnated as #{user.email}"
  end

  def destroy
    sign_in User.find(session[:reincarnated_user_id])
    session.delete(:reincarnated_user_id)

    redirect_to staff_root_path, notice: 'Returned from reincarnation'
  end
end
