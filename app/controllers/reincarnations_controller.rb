class ReincarnationsController < ApplicationController
  def create
    authorize :reincarnation

    session[:reincarnated_employee_id] = current_employee.id
    user = User.find(params[:user_id])
    sign_in user

    redirect_to root_path, notice: "Reincarnated as #{user.email}"
  end

  def destroy
    sign_in Employee.find(session[:reincarnated_employee_id])
    session.delete(:reincarnated_employee_id)

    redirect_to active_admin_root_path, notice: 'Returned from reincarnation'
  end
end
