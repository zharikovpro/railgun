class UserRolePolicy < ApplicationPolicy
  def create?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end
end
